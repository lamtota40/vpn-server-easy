#!/bin/bash

#SlowDNS
iptables -I INPUT -p udp --dport 5300 -j ACCEPT
iptables -I INPUT -m state --state NEW -m tcp -p tcp --dport 88 -j ACCEPT
iptables -t nat -I PREROUTING -i eth0 -p udp --dport 53 -j REDIRECT --to-ports 5300

#OpenVPN
iptables -t nat -I POSTROUTING -s 10.6.0.0/24 -o $CMD -j MASQUERADE
iptables -t nat -I POSTROUTING -s 10.7.0.0/24 -o $CMD -j MASQUERADE

iptables-save >/etc/iptables/rules.v4 >/dev/null 2>&1
iptables-save >/etc/iptables.up.rules >/dev/null 2>&1
netfilter-persistent save >/dev/null 2>&1
netfilter-persistent reload >/dev/null 2>&1
systemctl enable iptables >/dev/null 2>&1 
systemctl start iptables >/dev/null 2>&1 
systemctl restart iptables >/dev/null 2>&1 
