#!/bin/bash

#SSLH support multiplexer TCP UDP & Probes for HTTP, TLS/SSL (including SNI and ALPN), SSH, OpenVPN, tinc, XMPP, SOCKS5,

DEBIAN_FRONTEND=noninteractive apt-get install sslh --no-install-recommends -y
wget -O /etc/default/sslh.conf "https://raw.githubusercontent.com/lamtota40/vpn-server-easy/main/sslh/sslh.conf"
mkdir /etc/sslh
wget -O /etc/sslh/sslh.cfg "https://raw.githubusercontent.com/lamtota40/vpn-server-easy/main/sslh/sslh.cfg"
service sslh restart

 #sslh -F /etc/sslh/sslh.cfg
