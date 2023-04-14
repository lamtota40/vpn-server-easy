#!/bin/bash

if (( $EUID != 0 )); then
    echo "Please run as root"
    echo "You can Try comand 'su root' or 'sudo -i' or 'sudo -'"
    exit 1
fi

#dependency
apt update
apt upgrade -y
apt install python jq cron curl openssl iptables -y

site="https://raw.githubusercontent.com/lamtota40/vpn-server-easy/main"

#Banner
wget -P /etc $site/tools/other/banner

#install openSSH
wget $site/SSH/openssh/setup-openssh.sh && bash setup-openssh.sh

#install dropbear
wget $site/SSH/dropbear/setup-dropbear.sh && bash setup-dropbear.sh

#grep "/bin/false" /etc/shells
echo "/bin/false" >> /etc/shells

#grep "/bin/nologin" /etc/shells
echo "/usr/sbin/nologin" >> /etc/shells

#install stunnel4
wget $site/SSH/stunel4/setup-stunnel4.sh && bash setup-stunnel4.sh

#install badvpn
wget $site/VPN/badvpn/setup-badvpn.sh && bash setup-badvpn.sh

#install slowdns
#wget $site/dnstunnel/setup-dnstunnel.sh && bash setup-dnstunnel.sh

#install websocket
wget $site/websocket/setup-websocket.sh && bash setup-websocket.sh

#install sslh
#wget $site/sslh/setup-sslh.sh && bash setup-sslh.sh

#install nginx
#wget $site/nginx/nginx.conf && bash nginx.conf

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
useradd -m -s /bin/bash $Login
echo -e "$Pass\n$Pass\n" | passwd $Login &> /dev/null
usermod -aG sudo $Login

clear
echo "OK…finish installation..you can enter command 'menu'"

rm -rf setup-vpn.sh
