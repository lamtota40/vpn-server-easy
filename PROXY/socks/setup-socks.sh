#!/bin/bash

#Dante is proxy server shocks4 & shocks5
#The authentication method "username" is not supported by version 4 of the SOCKS protocol, only by SOCKS v5
#for testing: curl -v https://ipinfo.io --proxy "socks5://user:pass@ip:1080"

apt install dante-server -y
wget -O /etc/danted.conf https://raw.githubusercontent.com/lamtota40/vpn-server-easy/main/PROXY/socks/danted.conf
systemctl restart danted
systemctl enable danted

rm -rf setup-socks.sh
