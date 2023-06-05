#!/bin/bash

ETH=$(ip -o $ETH -4 route show to default | awk '{print $5}');

#Websocket Redirect
iptables -A PREROUTING -t nat -i eth0 -p tcp --dport 2086 -j REDIRECT --to-port 8880
iptables -A PREROUTING -t nat -i eth0 -p tcp --dport 2095 -j REDIRECT --to-port 8880
iptables -A PREROUTING -t nat -i eth0 -p tcp --dport 2053 -j REDIRECT --to-port 8043
iptables -A PREROUTING -t nat -i eth0 -p tcp --dport 2083 -j REDIRECT --to-port 8043
iptables -A PREROUTING -t nat -i eth0 -p tcp --dport 2087 -j REDIRECT --to-port 8043
iptables -A PREROUTING -t nat -i eth0 -p tcp --dport 2096 -j REDIRECT --to-port 8043

#SlowDNS
iptables -A INPUT -i eth0 -p udp --dport 53 -j ACCEPT
iptables -A INPUT -i eth0 -p udp --dport 5300 -j ACCEPT
iptables -A INPUT -i eth0 -p tcp --dport 2222 -j ACCEPT
iptables -t nat -I PREROUTING -i eth0 -p udp --dport 53 -j REDIRECT --to-ports 5300
#iptables -I INPUT -p udp --dport 5300 -j ACCEPT

#OpenVPN
iptables -t nat -I POSTROUTING -s 10.6.0.0/24 -o $ETH -j MASQUERADE
iptables -t nat -I POSTROUTING -s 10.7.0.0/24 -o $ETH -j MASQUERADE

iptables-save >/etc/iptables/rules.v4 >/dev/null 2>&1
iptables-save >/etc/iptables.up.rules >/dev/null 2>&1
netfilter-persistent save >/dev/null 2>&1
netfilter-persistent reload >/dev/null 2>&1
systemctl enable iptables >/dev/null 2>&1 
systemctl start iptables >/dev/null 2>&1 
systemctl restart iptables >/dev/null 2>&1

rm -rf setup-iptables.sh
