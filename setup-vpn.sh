#!/bin/bash

if (( $EUID != 0 )); then
    echo "Please run as root"
    echo "You can Try comand 'su root' or 'sudo -i' or 'sudo -'"
    exit 1
fi

#depency
apt update
apt upgrade -y
apt install cron curl openssl iptables -y

site="https://raw.githubusercontent.com/lamtota40/vpn-server-easy/main"
wget -P /etc $site/tools/other/banner

#grep "/bin/false" /etc/shells
echo "/bin/false" >> /etc/shells

#grep "/bin/nologin" /etc/shells
echo "/usr/sbin/nologin" >> /etc/shells

#install dropbear
wget $site/SSH/dropbear/setup-dropbear.sh && bash setup-dropbear.sh

#install stunnel4
wget $site/SSH/stunel4/setup-stunnel4.sh && bash setup-stunnel4.sh

#install badvpn
wget $site/VPN/badvpn/setup-badvpn.sh && bash setup-badvpn.sh

#install slowdns
#wget $site/dnstunnel/setup-dnstunnel.sh && bash setup-dnstunnel.sh

#install nginx
wget $site/nginx/nginx.conf && bash nginx.conf

#menu command
wget -O menu $site/tools/menu
chmod +x menu

#auto reboot 24Hours
wget -P /root $site/tools/autoreboot.sh
chmod +x /root/autoreboot.sh
echo "0 0 * * * root /root/autoreboot.sh" > /etc/cron.d/autoreboot
service cron reload
service cron restart

Login="master"
Pass="qwerty"
useradd -m $Login
echo -e "$Pass\n$Pass\n" | passwd $Login &> /dev/null
usermod -aG sudo $Login

rm -rf setup-vpn.sh
