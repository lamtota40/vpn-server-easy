#!/bin/bash

clear
echo "======================================"
echo "ADD account for UDP"
echo "Note: For cancel use CTRL+C"
echo "======================================"
read -p "input username     : " Login
read -p "Expired (day)      : " exp

expdate="$(chage -l $Login | grep "Account expires" | awk -F": " '{print $2}')"
clear
echo -e "==============================="
echo -e "Username         : udp "
echo -e "Password         : $Pass"
echo -e "Expired          : $expdate"
echo -e "Domain           : "
echo -e "IP         : 23,"
echo -e "Port      : 1-65535,"
echo -e "==============================="
                                 
