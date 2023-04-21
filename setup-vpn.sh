#!/bin/bash

if (( $EUID != 0 )); then
    echo "Please run as root"
    echo "You can Try comand 'su root' or 'sudo -i' or 'sudo -'"
    exit 1
fi

#dependency
apt update
apt upgrade -y
apt install python jq cron curl openssl iptables iptables-persistent net-tools -y

#for security
sysctl -w net.ipv6.conf.all.disable_ipv6=1 
sysctl -w net.ipv6.conf.default.disable_ipv6=1

site="https://raw.githubusercontent.com/lamtota40/vpn-server-easy/main"

#Banner welcome SSH
wget -P /etc $site/tools/other/banner

#install openSSH (SSH)
wget $site/SSH/openssh/setup-openssh.sh && bash setup-openssh.sh

#install dropbear (SSH)
wget $site/SSH/dropbear/setup-dropbear.sh && bash setup-dropbear.sh

#grep "/bin/false" /etc/shells
echo "/bin/false" >> /etc/shells

#grep "/bin/nologin" /etc/shells
echo "/usr/sbin/nologin" >> /etc/shells

#install OpenVPN
wget $site/VPN/openvpn/setup-openvpn.sh && bash setup-openvpn.sh

#install stunnel4/TLS
wget $site/SSH/stunel4/setup-stunnel4.sh && bash setup-stunnel4.sh

#install badvpn (For support UDP)
wget $site/VPN/badvpn/setup-badvpn.sh && bash setup-badvpn.sh

#install slowdns (ssh over dns)
wget $site/slowdns/setup-slowdns.sh && bash setup-slowdns.sh

#install websocket
wget $site/websocket/setup-websocket.sh && bash setup-websocket.sh

#install proxy squid
wget $site/PROXY/squid/setup-squid.sh && bash setup-squid.sh

#install shock4 & shock5
wget $site/PROXY/shock/setup-shock.sh && bash setup-shock.sh 

#install sslh (for sharing one port/multiplexer)
wget $site/sslh/setup-sslh.sh && bash setup-sslh.sh

#install nginx (website)
#wget $site/nginx/nginx.conf && bash nginx.conf

#install OHP
#wget $site/OHP/setup-ohp.sh && bash setup-ohp.sh

#menu command
wget -O menu $site/tools/menu
chmod +x menu

#auto reboot vps once at 00.00 clock
wget -P /root $site/tools/autoreboot.sh
chmod +x /root/autoreboot.sh
echo "0 0 * * * root /root/autoreboot.sh" > /etc/cron.d/autoreboot
service cron reload
service cron restart

#add user for admin default
Login="master"
Pass="qwerty"
useradd -m -s /bin/bash $Login
echo -e "$Pass\n$Pass\n" | passwd $Login &> /dev/null
usermod -aG sudo $Login

clear
echo "OK…finish installation..you can enter command 'menu'"

#cek status all service
if ! systemctl status squid &> /dev/null; then
    printf "\n[Failed] to install Squid\n"
fi

rm -rf setup-vpn.sh
