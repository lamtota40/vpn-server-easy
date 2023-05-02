#!/bin/bash

PUBLIC_IP=$(wget -4qO- ipinfo.io/ip);
clear
echo "======================================"
echo "ADD account for UDP"
echo "Note: For cancel use CTRL+C"
echo "======================================"
echo "Username         : udp "
read -p "input Password     : " pass
read -p "Expired (day)      : " exp

expdate="$(chage -l $Login | grep "Account expires" | awk -F": " '{print $2}')"
clear
echo -e"◇━━━━━━━━━━━━━━━━━◇"
echo -e"(UDP Account)-Zero Store"
echo -e"https://t.me/zerovpn3"
echo -e"◇━━━━━━━━━━━━━━━━━◇"
echo -e "Username   : udp "
echo -e "Password   : $pass"
echo -e "Expired    : $expdate"
echo -e "Domain     : "
echo -e "IP         : $PUBLIC_IP"
echo -e "Port       : 1-65535"
echo -e"◇━━━━━━━━━━━━━━━━━◇"                               
