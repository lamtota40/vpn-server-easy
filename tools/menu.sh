#!/bin/bash

PUBLIC_IP=$(wget -4qO- ipinfo.io/ip);
echo "================================"
echo "Time =" `date "+%H:%M:%S"`
echo "Date =" `date "+%d/%m/%y"`
echo "Uptime =" `uptime -p`
echo "Domain : "
echo "Ip Public = $PUBLIC_IP"
echo "location :"
echo "Cpu Usage : "
echo "RAM Free$(awk '{print $4}' <<< "$raminfo") (${ram_free_p%.*} %) | Usage = $(awk '{print $3}' <<< "$raminfo") | Total = $(awk '{print $2}' <<< "$raminfo")"
echo "================================"
echo " ++++++++++++ Menu ++++++++++++
echo "================================"
echo "1. Add user"
echo "2. list user"
echo "3. Who login"
echo "4. Settings"
echo "5. Detail server"
echo "6. Check/change port"
echo "7. Monitoring bandwith"
echo "8. Uninstall"
echo "9. "
echo "0. Quit"
echo "================================"
read -p "choose [0-9]:" num
