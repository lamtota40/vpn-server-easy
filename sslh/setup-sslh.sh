#!/bin/bash

#https://github.com/yrutschle/sslh
#SSLH support TCP UDP & Probes for HTTP, TLS/SSL (including SNI and ALPN), SSH, OpenVPN, tinc, XMPP, SOCKS5,

DEBIAN_FRONTEND=noninteractive apt-get install sslh --no-install-recommends -y
#port 443,5222,5228
wget -O /etc/default/sslh "https://raw.githubusercontent.com/lamtota40/vpn-server-easy/main/sslh/sslh.conf"
service sslh restart

[Unit]
Description=SSL/SSH multiplexer
After=network.target

[Service]
EnvironmentFile=/etc/conf.d/sslh
ExecStart=/usr/bin/sslh --foreground $DAEMON_OPTS
KillMode=process

[Install]
WantedBy=multi-user.target

rm -rf setup-sslh.sh


