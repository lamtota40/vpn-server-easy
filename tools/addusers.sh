#!/bin/bash
clear
echo "======================================"
echo "ADD user for SSH+Openvpn+Socks+UDP"
echo "Note: For cancel use CTRL+C"
echo "======================================"
read -p "input username     : " Login

/bin/egrep  -i "^${Login}:" /etc/passwd
if [ $? -eq 0 ]; then
	echo "User $Login exists Please create other User"
	read -p "Please Enter to Continue...."
	#/root/myvpn/addusers
fi

read -p "input password     : " Pass
read -p "Expired (day)      : " exp

useradd -e `date -d "$exp days" +"%Y-%m-%d"` -s /bin/false -M $Login
echo -e "$Pass\n$Pass\n" | passwd $Login &> /dev/null
#myip=$(wget -qO- ifconfig.me/ip)
cekip=$(curl -s "http://ip-api.com/json/")
domain="zerostore.sit.my.id"
expdate="$(chage -l $Login | grep "Account expires" | awk -F": " '{print $2}')"
clear
echo -e "â—‡â”â”â”â” Account Info â”â”â”â”â—‡"
echo -e "Username	: $Login"
echo -e "Password	: $Pass"
echo -e "Expired	: $(date +%d/%m/%y -d "$expdate")"
echo -e "â—‡â”â”â”â”â”â”â”â”â”â”â”â”â”â”â”â”â”â—‡"
echo -e "Host CF	: $domain"
echo -e "IP             : $(jq -r '.query' <<< "$cekip")"
echo -e "ISP		: $(jq -r '.isp' <<< "$cekip") | $(jq -r '.country' <<< "$cekip")"
echo -e "Host Bug	: bug.$domain"
echo -e "Note: bug bisa di ganti bebas"
echo -e "â—‡â”â”â”â”â” Non TLS â”â”â”â”â”â”â—‡"
echo -e "OpenSSH	:22,143,8000"
echo -e "Dropbear	:23,144,7000"
echo -e "WS Dropbear	:80,2082,8880"
echo -e "â—‡â”â”â”â”â” SSL / TLS â”â”â”â”â”â—‡"
echo -e "OpenSSH	:955,465"
echo -e "Dropbear	:944,587"
echo -e "Ws Dropbear	:443"
echo -e "â—‡â”â”â”â” Mode Proxy â”â”â”â”â”â—‡"
echo -e "OHP OpenSSH	:8080"
echo -e "OHP Dropbear	:8181"
echo -e "Squid	:3128"
echo -e "Socks5	:1080"
echo -e "â—‡â”â”â”â”â”â”â”â”â”â”â”â”â”â”â”â”â”â—‡"
echo -e "UDPcustom	:1-65535"
echo -e "BadVPN/UDPGW	:7200,7300"
echo -e "Reboot VPS	: 00.00 (GMT+7)"
echo -e "â—‡â”â”â”â”â”â”â”â”â”â”â”â”â”â”â”â”â”â—‡"
echo -e "GET / HTTP/1.1[crlf]Host: [host][crlf]User-Agent: [ua][crlf]Upgrade: websocket[crlf][crlf]"
echo -e "\nâ—‡â”â”â”â”â”â”â”â”â”â”â”â”â”â”â”â”â”â—‡"
