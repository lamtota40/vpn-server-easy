#!/bin/bash

PUBLIC_IP=$(wget -4qO- ipinfo.io/ip);

apt install squid -y
mv /etc/squid/squid.conf /etc/squid/squid.conf.bak
wget -P /etc/squid/ "https://raw.githubusercontent.com/lamtota40/vpn-server-easy/main/PROXY/squid/squid.conf"
sed -i $PUBLIC_IP /etc/squid/squid.conf
systemctl restart squid

if ! systemctl status squid &> /dev/null; then
    printf "\nFailed to install Squid\n" && err
fi
