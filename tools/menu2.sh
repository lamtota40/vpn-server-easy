#!/bin/bash

clear
PUBLIC_IP=$(wget -4qO- ipinfo.io/ip);
raminfo=$(free -m | grep Mem)=$(free | grep Mem | awk '{print $4/$2 * 100}')
rram_usage=($(awk '{print $2}' <<< "$raminfo")-$(awk '{print $4}' <<< "$raminfo"))
ram_usage=(free | grep Mem | awk '{print $2-$4}')
ram_free_p=$(free | grep Mem | awk '{print $4/$2 * 100}')
swap_free_p=$(free | grep Mem | awk '{print $4/$2 * 100}')
cekip=$(curl -s "https://get.geojs.io/v1/ip/geo.json")
domain="zerostore.sit.my.id"

echo "================================"
echo "Time	 :" `date "+%H:%M:%S"` "|" `date "+%d/%m/%y"`
echo "Uptime	 :" `uptime -p`
echo "Host	 : $domain | $PUBLIC_IP"
echo "ISP	 : $(jq -r '.organization_name' <<< "$cekip") | Country= $(jq -r '.country' <<< "$cekip")"
echo "RAM	 : Usage = $ram_usage (${ram_free_p%.*} %) | Free= $(awk '{print $4}' <<< "$raminfo") (${ram_free_p%.*} %) | Total = $(awk '{print $2}' <<< "$raminfo") "
echo "SWAP RAM : [Free = $(awk 'FNR == 2 {print$3-$4}' <<< "$swapinfo" | numfmt --to=iec) (${ram_free_p%.*} %) | Usage = $(awk 'FNR == 2 {print$4}' <<< "$swapinfo" | numfmt --to=iec) | Total = $(awk 'FNR == 2 {print$3}' <<< "$swapinfo" | numfmt --to=iec) ]"
echo "================================"
echo " ++++++++++++ Menu ++++++++++++"
echo "================================"
echo "1. ADD USER"
echo "2. List/Extend/Delete USER"
echo "3. Who Login"
echo "4. Service Manager"
echo "5. Monitoring Bandwith"
echo "6. Change Banner SSH"
echo "7. Settings"
echo "8. Security"
echo "9. Tools"
echo "0. Quit"
echo "================================"
read -p "Choose Menu [0-9] :" num
case $num in
1)
	clear
	echo "1. Add user for SSH+OpenVPN+Socks5"
	echo "2. Add User for UDP"
	echo "3. Add User for V2ray(Vmess/Vless/Tojan/shadowsocks)"
	echo "0. Back to menu"
	read -p "Choose Menu [0-3] :" num1
	case $num1 in
	1)
	/root/myvpn/adduser
	;;
	2)
	/root/myvpn/addudp
	;;
	3)
	/root/myvpn/addv2ray
	;;
	0)
	/usr/sbin/menu
	;;
	esac
;;
2)
	clear
	echo "================================================="
	echo "1. List User SSH+OpenVPN+Socks"
	echo "2. List User UDP"
	echo "3. List User V2ray(Vmess/Vless/Trojan/Shadowsocks)"
	echo "================================================="
	echo "4. Extend User SSH+OpenVPN+Socks"
	echo "5. Extend User UDP"
	echo "6. Extend User V2ray(Vmess/Vless/Trojan/Shadowsocks)"
  echo "================================================="
	echo "7. Delete User SSH+OpenVPN+Socks"
	echo "8. Delete User UDP"
	echo "9. Delete User V2ray(Vness/Vless/Trojan/Shadowsocks)"
	echo "=================================================="
	echo "0. Back to MENU"
	read -p "Choose [0-9] :" num2
	case $num2 in
	0)
	/usr/sbin/menu
	;;
	esac
;;
3)
	clear
	/root/myvpn/whologin
;;
6)
	clear
	echo "================================="
	echo "Note :"
	echo "For Save press (Ctrl+o & Enter)"
	echo "For Exit press (Ctrl+x)"
	echo "================================="
	read -p "To Continue press Enter...."
	nano /etc/banner
;;
9)
	clear
	echo "1. Detail Server"
	echo "2. Speedtest"
	echo "3. Benchmark"
	echo "9. Unistall"
	read -p "Choose [0-9] :" num9
	case $num9 in
	1)
	clear
	/root/myvpn/detailserver
	;;
	2)
	clear
	/root/myvpn/speedtest
	;;
	esac
;;
0)
	exit 1
;;
esac
