#!/bin/bash

#SSLH support multiplexer TCP UDP & Probes for HTTP, TLS/SSL (including SNI and ALPN), SSH, OpenVPN, tinc, XMPP, SOCKS5,

DEBIAN_FRONTEND=noninteractive apt-get install sslh --no-install-recommends -y
wget -O /etc/default/sslh.conf "https://raw.githubusercontent.com/lamtota40/vpn-server-easy/main/sslh/sslh.conf"
mkdir /etc/sslh
wget -O /etc/sslh/sslh.cfg "https://raw.githubusercontent.com/lamtota40/vpn-server-easy/main/sslh/sslh.cfg"

cat <<EOF > /etc/systemd/system/sslh880.service
[Unit]
Description=SSL/SSH multiplexer
After=network.target

[Service]
ExecStart=/usr/sbin/sslh --foreground --user sslh --listen 0.0.0.0:880 --ssh 127.0.0.1:23 --openvpn 127.0.0.1:1194 --http 127.0.0.1:8880 --pidfile /var/run/sslh/sslh880.pid
KillMode=process

[Install]
WantedBy=multi-user.target
EOF

systemctl daemon-reload
systemctl enable sslh
systemctl start sslh
systemctl restart sslh

systemctl enable sslh880
systemctl start sslh880
systemctl restart sslh880
##################################

rm -rf setup-sslh.sh

#sslh -F /etc/sslh/sslh.cfg
