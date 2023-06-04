#!/bin/bash

if (( $EUID != 0 )); then
    echo "Please run as root"
    echo "You can Try comand 'su root' or 'sudo -i' or 'sudo -'"
    exit 1
fi

#disable ipv6
#echo "net.ipv6.conf.all.disable_ipv6 = 1" >> /etc/sysctl.conf
#echo "net.ipv6.conf.default.disable_ipv6 = 1" >> /etc/sysctl.conf
#echo "net.ipv6.conf.eth0.disable_ipv6 = 1" >> /etc/sysctl.conf
#echo "net.ipv6.conf.lo.disable_ipv6 = 1" >> /etc/sysctl.conf
#sysctl -p

read -p "input your domain = " domain
read -p "input your NS Domain = " nsdomain

#create directory
cd
mkdir -p /root/myvpn
mkdir -p /root/myvpn/cron
mkdir -p /root/myvpn/log
mkdir -p /root/myvpn/data
mkdir -p /root/myvpn/config

echo $domain > /root/myvpn/domain
echo $nsdomain > /root/myvpn/nsdomain

#dependency
#apt install python jq cron curl openssl iptables iptables-persistent net-tools -y
apt install gcc lsof make parted iptables python jq cron curl openssl net-tools unzip rsyslog -y

site="https://raw.githubusercontent.com/lamtota40/vpn-server-easy/main"

#remove firewall
apt-get remove --purge ufw firewalld -y

#change Timezone
cekip=$(curl -s "http://ipinfo.io")
timezone=$(jq -r '.timezone' <<< "$cekip")
ln -fs /usr/share/zoneinfo/$timezone /etc/localtime

#disable syslog
sed -i '/\/var\/log\/syslog/{s/^/#/}' /etc/rsyslog.d/50-default.conf
service rsyslog restart

# nano /etc/rc.local
##cat > /etc/rc.local <<-END
#!/bin/sh -e
# rc.local
# By default this script does nothing.
##exit 0
##END

# Ubah izin akses
##chmod +x /etc/rc.local
##systemctl enable rc-local
##systemctl start rc-local.service

# disable ipv6
#echo 1 > /proc/sys/net/ipv6/conf/all/disable_ipv6

#add user for admin default
grep "/bin/false" /etc/shells || echo "/bin/false" >> /etc/shells
grep "/bin/nologin" /etc/shells || echo "/usr/sbin/nologin" >> /etc/shells

Login="master"
Pass="qwerty"
useradd -m -s /bin/bash $Login
echo -e "$Pass\n$Pass\n" | passwd $Login &> /dev/null
usermod -aG sudo $Login

cd
#ADD Extra Ram Swap 2GB
wget -O setup-ramswap.sh $site/tools/setup-ramswap.sh && bash setup-ramswap.sh

#Banner welcome SSH
wget -O /etc/banner $site/tools/other/banner

#install openSSH (SSH)
wget -O setup-openssh.sh $site/SSH/openssh/setup-openssh.sh && bash setup-openssh.sh

#install dropbear (SSH)
wget -O setup-dropbear.sh $site/SSH/dropbear/setup-dropbear.sh && bash setup-dropbear.sh

#install stunnel4/TLS
wget -O setup-stunnel4.sh $site/stunnel4/setup-stunnel4.sh && bash setup-stunnel4.sh

#install badvpn (For support UDP/videocall,etc)
wget -O setup-badvpn.sh $site/VPN/badvpn/setup-badvpn.sh && bash setup-badvpn.sh

#install websocket
wget -O setup-websocket.sh $site/websocket/setup-websocket.sh && bash setup-websocket.sh

#install proxy squid
wget -O setup-squid.sh $site/PROXY/squid/setup-squid.sh && bash setup-squid.sh

#install socks4 & socks5
wget -O setup-socks.sh $site/PROXY/socks/setup-socks.sh && bash setup-socks.sh 

#install sslh (for sharing one port/multiplexer)
wget -O setup-sslh.sh $site/sslh/setup-sslh3.sh && bash setup-sslh.sh

#install OHP [require install proxy+ssh]
wget -O setup-ohp.sh $site/OHP/setup-ohp.sh && bash setup-ohp.sh
#apt install iptables-persistent -y

#install slowdns [require OpenSSH]
wget -O setup-slowdns.sh $site/slowdns/setup-slowdns.sh && bash setup-slowdns.sh

#install vnstat(for monitoring bandwith)
wget -O setup-vnstat.sh $site/tools/vnstat/setup-vnstat.sh && bash setup-vnstat.sh

#install nginx (website)
wget -O setup-nginx.sh $site/nginx/setup-nginx.sh && bash setup-nginx.sh

#install OpenVPN
wget -O setup-openvpn.sh $site/VPN/openvpn/setup-openvpn.sh && bash setup-openvpn.sh
#wget https://raw.githubusercontent.com/godtrex99/V2vps/1c0d89c80a81661cca63eed089f0b72492b2fddc/ssh/vpn.sh && bash vpn.sh

#install UDP custom
wget -O setup-UDPcustom.sh $site/UDPcustom/setup-UDPcustom.sh && bash setup-UDPcustom.sh

#Setting IPTABLES
wget -O setup-iptables.sh $site/tools/setup-iptables.sh && bash setup-iptables.sh

#download menu & tools
wget -O setup-tools.sh $site/tools/setup-tools.sh && bash setup-tools.sh
wget -O /usr/sbin/menu $site/tools/menu.sh && chmod +x /usr/sbin/menu

#autostartup lunch menu
cd
echo 'if [[ -n $SSH_CONNECTION ]] ; then' | sudo tee -a ~/.bashrc
echo '/usr/sbin/menu' | sudo tee -a ~/.bashrc
echo 'fi' | sudo tee -a ~/.bashrc

#Cron (Auto Run Task)
#for Job cron gererator : https://cronexpressiontogo.com
#Auto reboot vps once at 00.05 clock
wget -O /root/myvpn/cron/autoreboot $site/tools/cron/autoreboot.sh
chmod +x /root/myvpn/cron/autoreboot
echo "5 0 * * * root /root/myvpn/cron/autoreboot" > /etc/cron.d/autoreboot

#auto delete user expired once at 00.15 clock
wget -O /root/myvpn/cron/autodelexp $site/tools/cron/autodelexp.sh
chmod +x /root/myvpn/cron/autodelexp
echo "15 0 * * * root /root/myvpn/cron/autodelexp" > /etc/cron.d/autodelexp

#auto clear cache RAM/Buffer/SWAP/HDDlog every 4 hours
wget -O /root/myvpn/cron/autoclearcache $site/tools/cron/autoclearcache.sh
chmod +x /root/myvpn/cron/autoclearcache
echo "0 */4 * * * root /root/myvpn/cron/autoclearcache" > /etc/cron.d/autoclearcache

service cron reload
service cron restart

#setup lolcat for colouring text
cd
apt install lolcat ruby -y
wget -O lolcat.zip https://github.com/busyloop/lolcat/archive/master.zip
unzip lolcat.zip
cd lolcat-master/bin
gem install lolcat
cd
rm -rf lolcat.zip
rm -rf lolcat-master

#cek status all service
wget -O status.sh $site/tools/status.sh
clear
bash status.sh

echo "OK…finish installation..you can enter command 'menu'"
history -c
rm -rf setup-vpn.sh
