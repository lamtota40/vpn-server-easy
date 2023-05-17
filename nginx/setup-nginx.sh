#!/bin/bash

apt install nginx -y
sytemctl stop nginx
/etc/nginx/sites-enabled/default
sytemctl start nginx

rm -rf setup-nginx.sh
