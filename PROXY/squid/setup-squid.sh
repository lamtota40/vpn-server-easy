#!/bin/bash

PUBLIC_IP=$(wget -4qO- ipinfo.io/ip);

apt install squid apache2-utils -y
mv /etc/squid/squid.conf /etc/squid/squid.conf.bak
wget -P /etc/squid/ "https://raw.githubusercontent.com/lamtota40/vpn-server-easy/main/PROXY/squid/squid.conf"
PUBLIC_IP2="s/xxxxxxxxx/$PUBLIC_IP/g";
sed -i $PUBLIC_IP2 /etc/squid/squid.conf
systemctl restart squid
#systemctl reload squid

if ! systemctl status squid &> /dev/null; then
    printf "\nFailed to install Squid\n" && err
fi
