#!/bin/bash

PUBLIC_IP=$(wget -4qO- ipinfo.io/ip);

apt install squid -y
mv /etc/squid/squid.conf /etc/squid/squid.conf.bak
curl -skL "https://raw.githubusercontent.com/lamtota40/vpn-server-easy/main/PROXY/squid/squid.conf" -o /etc/squid/squid.conf
sed -i "s/xxxx/$PUBLIC_IP/g" /etc/squid/squid.conf
systemctl restart squid
if ! systemctl status squid &> /dev/null; then
    printf "\nFailed to install Squid\n" && err
fi
