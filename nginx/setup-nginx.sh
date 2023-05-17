#!/bin/bash

apt install nginx -y
sytemctl stop nginx
#/var/www/html
wget -O /etc/nginx/sites-enabled/default https://raw.githubusercontent.com/lamtota40/vpn-server-easy/main/nginx/nginx.conf
sytemctl start nginx
sytemctl restart nginx

rm -rf setup-nginx.sh
