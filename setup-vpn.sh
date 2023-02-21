#!/bin/bash

if (( $EUID != 0 )); then
    echo "Please run as root"
    echo "You can Try comand 'su root' or 'sudo -i' or 'sudo -'"
    exit 1
fi

site="https://raw.githubusercontent.com/lamtota40/vpn-server-easy/main"

apt update
apt upgrade -y
apt install curl openssl -y
wget -P /etc $site/tools/other/banner

#install dropbear
wget $site/SSH/dropbear/setup-dropbear.sh && bash setup-dropbear.sh

#install stunnel4
wget $site/SSH/stunel4/setup-stunnel4.sh && bash setup-stunnel4.sh

#create account
echo "==================================="
read -p "input username     : " user
read -p "input password     : " pass

echo "/bin/false" >> /etc/shells
echo "/usr/sbin/nologin" >> /etc/shells

#-1=MD5,-5=SHA256,-6=SHA512 (recommend)
$cryptpass='openssl passwd -6 -salt xyz $pass'
useradd -s /bin/false -p $cryptpass -M $user
