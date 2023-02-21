#!/bin/bash

echo "==================================="
read -p "input username     : " Login
read -p "input password     : " Pass

echo "/bin/false" >> /etc/shells
echo "/usr/sbin/nologin" >> /etc/shells

pass=$(perl -e 'print crypt($ARGV[0], "password")' $password)
useradd -s /bin/false -p $pass -M $Login

echo -e "==============================="
echo -e "Thank You For Using Our Services"
echo -e "SSH & OpenVPN Account Info"
echo -e "Username       : $Login "
echo -e "Password       : $Pass"
echo -e "==============================="
echo -e "Domain         : $domain"
echo -e "Host           : $IP"
echo -e "OpenSSH        : 22"
echo -e "Dropbear       : 109, 143"
echo -e "SSL/TLS        :$ssl"
echo -e "Port Suid      :$sqd"
echo -e "Port Websocket : 443, 8880"
echo -e "OpenVPN        : TCP $ovpn http://$IP:81/client-tcp-1194.ovpn"
echo -e "OpenVPN        : UDP $ovpn2 http://$IP:81/client-udp-2200.ovpn"
echo -e "OpenVPN        : SSL 442 http://$IP:81/client-tcp-ssl.ovpn"
echo -e "badvpn         : 7100-7300"
echo -e "==============================="
echo -e "PAYLOAD"                                                          
echo -e "GET / HTTP/1.1[crlf]Host: $domain[crlf]Connection: Keep-Alive[crlf]User-Agent: [ua][crlf]Upgrade: websocket[crlf][crlf]"
echo -e "==============================="
echo -e "SETING HOST SSH"               
echo -e "bugisisendiri:2082@$Login:$Pass"
echo -e "==============================="
echo -e "Script Install  : "
echo -e "Expired On      : $exp"
echo -e "==============================="
