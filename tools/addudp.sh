#!/bin/bash
clear

PUBLIC_IP=$(wget -4qO- ipinfo.io/ip);
domain="zerostore.sit.my.id"
username="udp"
echo "======================================"
echo "ADD account for UDP"
echo "Note: For cancel use CTRL+C"
echo "======================================"
echo "Username     : $username "
echo "Please input!"
read -p "Password     : " pass
read -p "Expired (day): " exp

pasword=$pass
#expdate="$(chage -l $Login | grep "Account expires" | awk -F": " '{print $2}')"
clear
echo "◇━━━━━━━━━━━━━━━━━◇"
echo "##### UDP Account #####"
echo "https://t.me/zerovpn3"
echo "◇━━━━━━━━━━━━━━━━━◇"
echo -e "Username : $username "
echo -e "Pasword  : $pasword"
echo -e "Domain   : $domain"
echo -e "IP       : $PUBLIC_IP"
echo -e "Port     : 1-655352"
echo -e "Expired  : $exp"
echo "◇━━━━━━━━━━━━━━━━━◇"                               
