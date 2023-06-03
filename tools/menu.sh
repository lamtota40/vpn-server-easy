#!/bin/bash

if (( $EUID != 0 )); then
    echo "Please run as root"
    echo "You can Try comand 'su root' or 'sudo -i' or 'sudo -'"
    exit 1
fi

YEL='\033[1;33m'
PINK='\e[1;49;95m'
RED='\033[0;31m'
BLUE='\033[1;96m'
Cyan='\033[0;96m'
WB='\e[37;1m'
NC='\033[0m'
clear
tuser="0"
Tssh=$(cat /etc/shadow | cut -d: -f1,8 | sed /:$/d | wc -l)
gmt_info=$(timedatectl | grep "Time zone" | awk -F"[()]" '{print $2}')
hddinfo=$(df -h --total | grep total)
raminfo=$(free -m | grep Mem)
ram_total=$(awk '{print $2}' <<< "$raminfo")
ram_usage=$(($(awk '{print $2}' <<< "$raminfo") - $(awk '{print $4}' <<< "$raminfo")))
swapinfo=$(free -m | grep Swap)
swap_total=$(awk '{print $2}' <<< "$swapinfo")
swap_usage=$(awk '{print $3}' <<< "$swapinfo")
if [ "$swap_usage" -eq "0" ]; then
swap_percent="0";
else
swap_percent=$(($swap_usage * 100 / $swap_total));
fi
hdd_usage=$(awk '{print $3}' <<< "$hddinfo")
hdd_total=$(awk '{print $2}' <<< "$hddinfo")
cekip=$(curl -s "http://ip-api.com/json/")
sfailed=$(systemctl --type=service | grep "failed" | wc -l)
domain=$(cat /root/myvpn/domain)
nsdomain=$(cat /root/myvpn/nsdomain)
dateinstall="14/05/23"
explicen="lifetime"
daily_usage=$(vnstat -d --oneline | awk -F\; '{print $6}' | sed 's/ //')
monthly_usage=$(vnstat -m --oneline | awk -F\; '{print $11}' | sed 's/ //')

echo -e "\e[36m╒══════════════════════════════════════════════════╕\033[0m"
echo -e " \E[46;1;37m                    INFO SERVER                   \E[0m"
echo -e "\e[36m╘══════════════════════════════════════════════════╛\033[0m"
echo -e "${PINK}Time${NC}	 :${BLUE}" `date "+%H:%M"` "|" `date "+%d/%m/%y"` "| $gmt_info ${NC}"
echo -e "${PINK}Uptime${NC}	 :${BLUE}" `uptime -p`"${NC}"
echo -e "${PINK}Host${NC}	 :${BLUE} $domain | $(jq -r '.query' <<< "$cekip")${NC}"
echo -e "${PINK}NS Host${NC}	 :${BLUE} $nsdomain ${NC}"
echo -e "${PINK}ISP${NC}	 :${BLUE} $(jq -r '.isp' <<< "$cekip") | $(jq -r '.country' <<< "$cekip") ${NC}"
echo -e "${PINK}RAM${NC}	 :${BLUE} Usage = ${YEL}"$ram_usage"Mb ($(($ram_usage * 100 / $ram_total))%) ${BLUE}| Total = ${YEL}"$ram_total"Mb ${NC}"
echo -e "${PINK}SWAP RAM${NC} :${BLUE} Usage = ${YEL}"$swap_usage"Mb ("$swap_percent"%) ${BLUE}| Total = ${YEL}"$swap_total"Mb ${NC}"
echo -e "${PINK}HDD${NC}      :${BLUE} Usage = ${YEL}$hdd_usage   ($(awk '{print $5}' <<< "$hddinfo")) ${BLUE}| Total =${YEL} $hdd_total ${NC}"
echo -e "${PINK}Service${NC}  :${RED} $sfailed OFF ${BLUE} |  Total 60 ${NC}"
echo -e "${BICyan}┌──────────────────────────────────────────────────┐${NC}"
echo -e "${BICyan} \033[0m ${BOLD}${YELLOW} SSH     VMESS     VLESS     TROJAN     SHADOW  $NC ${BICyan} "
echo -e "   $Tssh      $tuser      $tuser         $tuser        $tuser"
echo -e "${BICyan}└──────────────────────────────────────────────────┘${NC}"
echo -e "${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m${NC}" | lolcat
echo -e "  ${PINK}༶ ━━━━━━━━ [ Bandwidth Monitoring ] ━━━━━━━━ ༶   ${NC}"
echo -e "\033[0m ${WB}Today ($(date +%d/%m/%Y))           Monthly ($(date +%B/%Y))${NC}  "
echo -e "\033[0m ↓↓ Total: ${YEL}$daily_usage${NC}          ↓↓ Total: ${YEL}$monthly_usage${NC}"
echo -e "${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m${NC}" | lolcat
echo -e " \E[42;1;37m            Author (Bang EL) - V2.1               \E[0m"
echo -e " \E[44;1;37m Install : $dateinstall           Exp : $explicen      \E[0m"
echo -e "\e[36m╒══════════════════════════════════════════════════╕\033[0m"
echo -e " \E[41;1;37m                      MENU                        \E[0m"
echo -e "\e[36m╘══════════════════════════════════════════════════╛\033[0m"
echo -e "[1]. ${YEL}ADD USER${NC}"
echo -e "[2]. ${YEL}Whois Login${NC}"
echo -e "[3]. ${YEL}List USERS (Block/Extend/Delete)${NC}"
echo -e "[4]. ${YEL}Service Manager${NC}"
echo -e "[5]. ${YEL}Monitoring Bandwith${NC}"
echo -e "[6]. ${YEL}Clear Cache Ram & Log HDD${NC}"
echo -e "[7]. ${YEL}Settings${NC}"
echo -e "[8]. ${YEL}Info Script${NC}"
echo -e "[9]. ${YEL}Tools${NC}"
echo -e "[0]. ${YEL}Exit Menu${NC}"
echo -e "\e[36m═══════════════════════════════════════════════════ \033[0m"
read -p "Choose Number Options [0-9] : " num
while ! [[ "${num}" =~ ^[0-9]$ || -z "${num}" ]]; do
echo -e "${RED} Wrong your input!${NC}"
read -p "Choose Number Options [0-9] : " num
done

case $num in
'')
	/usr/sbin/menu
;;
1)
	clear
	echo "1. Add User for SSH+OpenVPN+Socks5+UDPcustom"
	echo "2. Add User for V2ray(Vmess/Vless/Tojan/shadowsocks)"
	echo "3. Add User for All in one(SSH+V2ray)"
	echo "0. Back to Menu"
	read -p "Choose Options [0-3] : " num1
	case $num1 in
	1)
	clear
	/root/myvpn/addusers
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
	Clear
	/root/myvpn/whoislogin
	read -p "Back to Menu Press Enter...."
	/usr/sbin/menu
;;
3)
	clear
	echo "================================================="
	echo "1. List User SSH+OpenVPN+Socks+UDPcustom"
	echo "2. List User V2ray(Vmess/Vless/Trojan/Shadowsocks)"
	echo "0. Back to Menu"
	echo "================================================="
	read -p "Choose Options [0-2] :" num2
	case $num2 in
	1)
	clear
	/root/myvpn/listusers
	;;
	0)
	clear
	/usr/sbin/menu
	;;
	esac
;;
4)
	clear
	/root/myvpn/smanager
	read -p "Back to Menu Press Enter...."
	/usr/sbin/menu
;;
7)
	clear
	echo "1. Change Banner SSH"
	echo "2. Change Domain"
	echo "3. Change NS Domain"
	echo "4. Change Port"
	echo "5. Change Time Zone"
	echo "6. Change Swap Ram"
	echo "9. Change Password Root (Admin)"
	echo "0. Back to Menu"
	read -p "Choose Options [0-9] :" num7
	case $num7 in
	1)
	clear
	echo "================================="
	echo "Note :"
	echo "For Save press (CTRL+O & ENTER)"
	echo "For Exit press (CTRL+X)"
	echo "================================="
	echo "OR from URL file"
	echo "wget -O /etc/banner https://url"
	echo "================================="
	read -p "To Continue Press Enter...."
	nano /etc/banner
	;;
	2)
	clear
	echo "================================="
	echo "Note :"
	echo "For Save press (CTRL+O & ENTER)"
	echo "For Exit press (CTRL+X)"
	echo "Please input just Domain only"
	echo "Dont Use www. Example : mydomain.com"
	echo "================================="
	read -p "To Continue Press Enter...."
	nano /root/myvpn/domain
	;;
	3)
	clear
	echo "================================="
	echo "Note :"
	echo "For Save press (CTRL+O & ENTER)"
	echo "For Exit press (CTRL+X)"
	echo "Please input just Domain only"
	echo "Dont Use www. Example : ns.mydomain.com"
	echo "================================="
	read -p "To Continue Press Enter...."
	nano /root/myvpn/nsdomain
	;;
	9)
	clear
	echo "================================================"
	echo "		!!! WARNING !!!"
	echo "Note : Becareful your change password Root"
	echo "To Cancel press CTRL+C"
	echo "================================================"
	read -p  "Please input your New Password Root :" passroot
	read -p  "Please confrim your Password Root   :" passroot2
	#passwd $passroot
	echo "Success To change password root"
	read -p "Back To Menu Press Enter...."
	/usr/sbin/menu
	;;
	0)
	/usr/sbin/menu
	;;
	esac
;;
5)
	clear
	echo "1. Daily"
	echo "2. Monthly"
	echo "0. Back to Menu"
	read -p "Choose Options [0-2] :" num5
	case $num5 in
	1)
	clear
	vnstat -d
	read -p "Back to Menu Press [Enter]...."
	/usr/sbin/menu
	;;
	2)
	clear
	vnstat -m
	read -p "Back to Menu Press [Enter]...."
	/usr/sbin/menu
	;;
	0)
	clear
	/usr/sbin/menu
	;;
	esac
;;
9)
	clear
	echo "1. Detail Server"
	echo "2. Speedtest"
	echo "3. Benchmark"
	echo "4. Monitoring RAM"
	echo "7. Update Version Script"
	echo "8. Backup/Restore Data"
	echo "9. Reboot Server"
	echo "0. Back to Menu"
	read -p "Choose Options [0-3] :" num9
	case $num9 in
	1)
	clear
	/root/myvpn/detailserver
	read -p "Back To Menu Press Enter...."
	/usr/sbin/menu
	;;
	2)
	clear
	/root/myvpn/speedtest
	read -p "Back To Menu Press Enter...."
	/usr/sbin/menu
	;;
	4)
	clear
	/root/myvpn/ram
	read -p "Back To Menu Press Enter...."
	/usr/sbin/menu
	;;
	9)
	echo "To Cancel press CTRL+C"
	read -p "Press Enter For confirmation Reboot Server..."
	echo "Okay...Please wait 5 sec for Reboot Server"
	sleep 5
	reboot
	;;
	0)
	clear
	/usr/sbin/menu
	;;
	esac
;;
0)
	exit 1
;;
esac
