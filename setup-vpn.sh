#!/bin/bash

if (( $EUID != 0 )); then
    echo "Please run as root"
    echo "You can Try comand 'su root' or 'sudo -i' or 'sudo -'"
    exit 1
fi

#create directory
cd
mkdir -p /root/myvpn
mkdir -p /root/myvpn/data
mkdir -p /root/myvpn/config
mkdir -p /root/myvpn/cron

read -p "input your domain = " domain
echo $domain > /root/myvpn/domain
read -p "input your NS Domain = " domain
echo $domain > /root/myvpn/nsdomain

#dependency
#apt install python jq cron curl openssl iptables iptables-persistent net-tools -y
apt install iptables python jq cron curl openssl net-tools unzip -y

site="https://raw.githubusercontent.com/lamtota40/vpn-server-easy/main"

#remove firewall
sudo ufw disable
apt purge ufw -y

#change Timezone
cekip=$(curl -s "http://ipinfo.io")
timezone=$(jq -r '.timezone' <<< "$cekip")
ln -fs /usr/share/zoneinfo/$timezone /etc/localtime

#disable ipv6
sysctl -w net.ipv6.conf.all.disable_ipv6=1 
sysctl -w net.ipv6.conf.default.disable_ipv6=1

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

#install slowdns [require OpenSSH]
wget -O setup-slowdns.sh $site/slowdns/setup-slowdns.sh && bash setup-slowdns.sh

#install nginx (website)
#wget -O setup-nginx.sh $site/nginx/setup-nginx.sh && bash setup-nginx.sh

#install stunnel4/TLS
wget -O setup-stunnel4.sh $site/SSH/stunel4/setup-stunnel4.sh && bash setup-stunnel4.sh

#install badvpn (For support UDP/videocall,etc)
wget -O setup-badvpn.sh $site/VPN/badvpn/setup-badvpn.sh && bash setup-badvpn.sh

#install websocket
wget -O setup-websocket.sh $site/websocket/setup-websocket.sh && bash setup-websocket.sh

#install proxy squid
wget -O setup-squid.sh $site/PROXY/squid/setup-squid.sh && bash setup-squid.sh

#install socks4 & socks5
wget -O setup-socks.sh $site/PROXY/socks/setup-socks.sh && bash setup-socks.sh 

#install sslh (for sharing one port/multiplexer)
wget -O setup-sslh.sh $site/sslh/setup-sslh.sh && bash setup-sslh.sh

#install OHP [require install proxy+ssh]
wget -O setup-ohp.sh $site/OHP/setup-ohp.sh && bash setup-ohp.sh
#apt install iptables-persistent -y

#install OpenVPN
#wget -O setup-openvpn.sh $site/VPN/openvpn/setup-openvpn.sh && bash setup-openvpn.sh
#wget https://raw.githubusercontent.com/godtrex99/V2vps/1c0d89c80a81661cca63eed089f0b72492b2fddc/ssh/vpn.sh && bash vpn.sh

#install UDP custom
wget -O setup-UDPcustom.sh $site/UDPcustom/setup-UDPcustom.sh && bash setup-UDPcustom.sh

#download menu & tools
wget -O setup-tools.sh $site/tools/setup-tools.sh && bash setup-tools.sh
wget -O /usr/sbin/menu $site/tools/menu.sh && chmod +x /usr/sbin/menu

#autostartup lunch menu
cd
echo 'if [[ -n $SSH_CONNECTION ]] ; then' | sudo tee -a ~/.bashrc
echo '/usr/sbin/menu' | sudo tee -a ~/.bashrc
echo 'fi' | sudo tee -a ~/.bashrc

#Cron (Auto Run Task)
#auto reboot vps once at 01.00 clock
wget -O /root/myvpn/cron/autoreboot $site/tools/cron/autoreboot.sh
chmod +x /root/myvpn/cron/autoreboot
echo "0 0 1 * * root /root/myvpn/cron/autoreboot" > /etc/cron.d/autoreboot

#Auto start slowdns if error
#wget -O /usr/bin/slowdns-eror $site/slowdns/slowdns-error
#chmod +x /usr/bin/slowdns-eror
#echo "0 4 * * * root slowdns-eror" >> /etc/crontab
#echo "0 18 * * * root slowdns-eror" >> /etc/crontab
service cron reload
service cron restart

clear
#cek status all service
wget -O status.sh $site/tools/status.sh && bash status.sh

echo "OK…finish installation..you can enter command 'menu'"
history -c
rm -rf setup-vpn.sh
