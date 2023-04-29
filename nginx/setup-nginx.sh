#!/bin/bash

apt install nginx -y
rm /etc/nginx/sites-enabled/default
rm /etc/nginx/sites-available/default
wget -O /etc/nginx/nginx.conf "https://raw.githubusercontent.com/lamtota40/vpn-server-easy/main/nginx/nginx.conf"
mkdir -p /var/myvpn/public_html
mkdir -p /var/myvpn/public_html/file
#wget -O /etc/nginx/conf.d/vps.conf "https://raw.githubusercontent.com/lamtota40/vpn-server-easy/main/nginx/vps.conf"

cat > /var/myvpn/public_html/index.html
<!DOCTYPE html>
<html>
<head>
<title>Welcome</title>
</head>
<body>
<h1>Welcome to VPN bang EL</h1>
<p>LinuxTechi Test Page running on NGINX Web Server - Ubuntu 22.04</p>
</body>
</html>
END

/etc/init.d/nginx restart

rm -rf setup-nginx.sh
