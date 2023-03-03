#!/bin/bash

PUBLIC_IP=$(wget -4qO- ipinfo.io/ip);

apt install squid3 -y
mv /etc/squid3/squid.conf /etc/squid3/squid.conf.bak
wget -P /etc/squid3/ "https://raw.githubusercontent.com/lamtota40/vpn-server-easy/main/PROXY/squid/squid.conf"
sed -i $PUBLIC_IP /etc/squid3/squid.conf
systemctl restart squid3
if ! systemctl status squid3 &> /dev/null; then
    printf "\nFailed to install Squid\n" && err
fi
