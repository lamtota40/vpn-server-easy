#!/bin/bash

apt install nginx -y
rm /etc/nginx/sites-enabled/default
rm /etc/nginx/sites-available/default
wget -O /etc/nginx/nginx.conf "https://raw.githubusercontent.com/lamtota40/vpn-server-easy/main/nginx/nginx.conf"
mkdir -p /var/myvpn/public_html
wget -O /etc/nginx/conf.d/vps.conf "https://raw.githubusercontent.com/lamtota40/vpn-server-easy/main/nginx/vps.conf"
/etc/init.d/nginx restart

rm -rf setup-nginx.sh
