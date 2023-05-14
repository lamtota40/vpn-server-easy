#!/bin/bash

#https://github.com/yrutschle/sslh
#SSLH support TCP UDP & Probes for HTTP, TLS/SSL (including SNI and ALPN), SSH, OpenVPN, tinc, XMPP, SOCKS5,

DEBIAN_FRONTEND=noninteractive apt-get install sslh --no-install-recommends -y
wget -O /etc/default/sslh "https://raw.githubusercontent.com/lamtota40/vpn-server-easy/main/sslh/sslh.conf"
service sslh restart

cat <<EOF > /etc/systemd/system/sslh80.service
[Unit]
Description=SSL/SSH multiplexer
After=network.target

[Service]
EnvironmentFile=/etc/conf.d/sslh
ExecStart=/usr/bin/sslh --foreground --user sslh --listen 0.0.0.0:443 --ssh 127.0.0.1:23 --tls 127.0.0.1:955 --openvpn 127.0.0.1:111 --http 127.0.0.1:2082 --pidfile /var/run/sslh/sslh80.pid
KillMode=process

[Install]
WantedBy=multi-user.target
EOF

systemctl daemon-reload
systemctl enable sslh80
systemctl start sslh80

rm -rf setup-sslh.sh


