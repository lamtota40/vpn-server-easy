#!/bin/bash

#https://github.com/yrutschle/sslh
#SSLH support TCP UDP & Probes for HTTP, TLS/SSL (including SNI and ALPN), SSH, OpenVPN, tinc, XMPP, SOCKS5,

DEBIAN_FRONTEND=noninteractive apt-get install sslh --no-install-recommends -y
wget -O /etc/default/sslh "https://raw.githubusercontent.com/lamtota40/vpn-server-easy/main/sslh/sslh.conf"
service sslh restart

cat <<EOF > /etc/systemd/system/sslh443.service
[Unit]
Description=SSL/SSH multiplexer
After=network.target

[Service]
ExecStart=/usr/sbin/sslh --foreground --user sslh --listen 0.0.0.0:443 --ssh 127.0.0.1:23 --tls 127.0.0.1:955 --openvpn 127.0.0.1:111 --http 127.0.0.1:2082 --pidfile /var/run/sslh/sslh443.pid
KillMode=process

[Install]
WantedBy=multi-user.target
EOF

systemctl daemon-reload
systemctl enable sslh443
systemctl start sslh443
##########################
cat <<EOF > /etc/systemd/system/sslh77.service
[Unit]
Description=SSL/SSH multiplexer
After=network.target

[Service]
ExecStart=/usr/sbin/sslh --foreground --user sslh --listen 0.0.0.0:77 --ssh 127.0.0.1:22 --tls 127.0.0.1:944 --openvpn 127.0.0.1:111 --http 127.0.0.1:8880 --pidfile /var/run/sslh/sslh77.pid
KillMode=process

[Install]
WantedBy=multi-user.target
EOF

systemctl daemon-reload
systemctl enable sslh77
systemctl start sslh77

rm -rf setup-sslh.sh
