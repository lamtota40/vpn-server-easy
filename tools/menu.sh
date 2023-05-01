#!/bin/bash

PUBLIC_IP=$(wget -4qO- ipinfo.io/ip);
raminfo=$(free -h | grep Mem)
ram_free_p=$(free | grep Mem | awk '{print $4/$2 * 100}')
cekip=$(curl -s "https://get.geojs.io/v1/ip/geo.json")
domain="zerostore.sit.my.id"

echo "================================"
echo "Time =" `date "+%H:%M:%S"`
echo "Date =" `date "+%d/%m/%y"`
echo "Uptime =" `uptime -p`
echo "Domain : $domain"
echo "Ip Public = $PUBLIC_IP"
echo "ISP = $(jq -r '.organization_name' <<< "$cekip") | Country= $(jq -r '.country' <<< "$cekip")"
echo "RAM | Free= $(awk '{print $4}' <<< "$raminfo") (${ram_free_p%.*} %) | Usage = $(awk '{print $3}' <<< "$raminfo") | Total = $(awk '{print $2}' <<< "$raminfo")"
echo "SWAP RAM | Free = $(awk 'FNR == 2 {print$3-$4}' <<< "$swapinfo" | numfmt --to=iec) (${ram_free_p%.*} %) | Usage = $(awk 'FNR == 2 {print$4}' <<< "$swapinfo" | numfmt --to=iec) | Total = $(awk 'FNR == 2 {print$3}' <<< "$swapinfo" | numfmt --to=iec)"
echo "================================"
echo " ++++++++++++ Menu ++++++++++++"
echo "================================"
echo "1. ADD USER"
echo "2. List/Delete/Extend USER"
echo "3. Who login"
echo "4. Monitoring Bandwith
echo "5. Settings"
echo "6. Service Manager"
echo "7. "
echo "8. Security"
echo "9. Tools"
echo "0. Quit"
echo "================================"
read -p "choose [0-9]:" num
