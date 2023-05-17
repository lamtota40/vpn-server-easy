#!/bin/bash

apt install nginx -y
sytemctl stop nginx
wget -O /etc/nginx/sites-enabled/default
sytemctl start nginx
sytemctl restart nginx

rm -rf setup-nginx.sh
