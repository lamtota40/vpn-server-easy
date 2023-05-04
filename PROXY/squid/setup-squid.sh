#!/bin/bash

PUBLIC_IP=$(wget -4qO- ipinfo.io/ip);

apt install squid apache2-utils -y
mv /etc/squid/squid.conf /etc/squid/squid.conf.bak
wget -O /etc/squid/squid.conf https://raw.githubusercontent.com/lamtota40/vpn-server-easy/main/PROXY/squid/ssh-squid.conf
PUBLIC_IP2="s/xxxxxxxxx/$PUBLIC_IP/g";
sed -i $PUBLIC_IP2 /etc/squid/squid.conf

cat > /etc/squid/blockURL << END
block1.com
.block2.com
END

#systemctl restart squid
systemctl reload squid

rm -rf setup-squid.sh
