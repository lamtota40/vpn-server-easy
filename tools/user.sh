#!/bin/bash

echo "==================================="
read -p "input username     : " Login
read -p "input password     : " Pass
read -p "Expired (day)      : " exp

useradd -e `date -d "$exp days" +"%Y-%m-%d"` -s /bin/false -M $Login
echo -e "$Pass\n$Pass\n" | passwd $Login &> /dev/null

expdate="$(chage -l $Login | grep "Account expires" | awk -F": " '{print $2}')"
clear
echo -e "==============================="
echo -e "Thank You For Using Our Services"
echo -e "SSH & OpenVPN Account Info"
echo -e "Username       : $Login "
echo -e "Password       : $Pass"
echo -e "Expired        : $expdate"
echo -e "==============================="
echo -e "IP             : "
echo -e "Host           : "
echo -e "OpenSSH port   : "
echo -e "Dropbear port  : "
echo -e "SSL/TLS        : "
echo -e "Squid port     : "
echo -e "Websocket port : "
echo -e "OpenVPN TCP    : http://localhost:81/client-tcp-1194.ovpn"
echo -e "OpenVPN UDP    : http://localhost:81/client-udp-2200.ovpn"
echo -e "OpenVPN SSL    : http://localhost:81/client-tcp-ssl-443.ovpn"
echo -e "Badvpn         : 7100-7300"
echo -e "==============================="
echo -e "PAYLOAD"                                                          
echo -e "GET / HTTP/1.1[crlf]Host: domain[crlf]Connection: Keep-Alive[crlf]User-Agent: [ua][crlf]Upgrade: websocket[crlf][crlf]"
echo -e "==============================="
echo -e "SETING HOST SSH"               
echo -e "IP/Host:port@Login:Pass"
echo -e "==============================="
