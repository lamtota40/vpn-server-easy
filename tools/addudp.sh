#!/bin/bash
clear

PUBLIC_IP=$(wget -4qO- ipinfo.io/ip);
domain="zerostore.sit.my.id"
username="udp"

echo "======================================"
echo "2ADD account for UDP"
echo "Note: For cancel use CTRL+C"
echo "======================================"
echo "Username     : $username "
echo -e "\nPlease input!"
read -p "Password     : " pass
read -p "Expired (day): " exp

pasword=$pass
#ddate=$(date '+%d-%m-%Y')
expdate=$(date -d "+$exp days")
#expdate="$(chage -l $Login | grep "Account expires" | awk -F": " '{print $2}')"
clear
echo "◇━━━━━━━━━━━━━━━━━◇"
echo "##### UDP Account #####"
echo "https://t.me/zerovpn3"
echo "◇━━━━━━━━━━━━━━━━━◇"
echo "Username : $username "
echo "Pasword  : $pasword"
echo "Domain   : $domain"
echo "IP       : $PUBLIC_IP"
echo "Port     : 1-655359"
echo "Expired  : $expdate"
echo "◇━━━━━━━━━━━━━━━━━◇"                               
