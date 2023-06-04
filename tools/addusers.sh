#!/bin/bash

clear
echo "======================================"
echo "ADD user for SSH+Openvpn+Socks+UDP"
echo "Note: For cancel use CTRL+C"
echo "======================================"
read -p "input username     : " Login

while [[ "$Login" =~ [^a-zA-Z0-9.-] || -z "$Login" || $Login =~ ^[0-9]+$ ]]
do
echo " Wrong input.. Dont input only number/special character!"
read -p "input username     : " Login
done

/bin/egrep  -i "^${Login}:" /etc/passwd
if [ $? -eq 0 ]; then
	echo " User $Login exists, Please create other Username!!"
	read -p "Please [Enter] to Continue...."
	/root/myvpn/addusers
	exit
fi

read -p "input password     : " Pass
read -p "Expired (day)      : " exp

while [[ !( $exp =~ ^[0-9]+$ ) || "$exp" -gt 365 ]]
do
echo " Wrong input.. Please input 0 - 365 day"
read -p "Expired (day)      : " exp
done

useradd -e `date -d "$exp days" +"%Y-%m-%d"` -s /bin/false -M $Login
echo -e "$Pass\n$Pass\n" | passwd $Login &> /dev/null
cekip=$(curl -s "http://ip-api.com/json/")
domain=$(cat /root/myvpn/domain)
nsdomain=$(cat /root/myvpn/nsdomain)
pubkey=$(cat /etc/slowdns/server.pub)
expdate="$(chage -l $Login | grep "Account expires" | awk -F": " '{print $2}')"
clear
echo -e "◇━━━━ Account Info ━━━━◇"
echo -e "Username	: $Login"
echo -e "Password	: $Pass"
echo -e "Expired	: $(date +%d/%m/%y -d "$expdate")"
echo -e "◇━━━━━━━━━━━━━━━━━◇"
echo -e "Host CF	: $domain"
echo -e "IP             : $(jq -r '.query' <<< "$cekip")"
echo -e "ISP		: $(jq -r '.isp' <<< "$cekip") | $(jq -r '.country' <<< "$cekip")"
echo -e "Host Bug	: bug.$domain"
echo -e "Note: you can change sub domain bug to Any"
echo -e "◇━━━━━ Non TLS ━━━━━━◇"
echo -e "OpenSSH	:22,143,8000"
echo -e "Dropbear	:23,144,7000"
echo -e "WS OpenSSH	:8880"
echo -e "WS Dropbear	:80,2082"
echo -e "WS OpenVPN	:80,2082"
echo -e "◇━━━━━ SSL / TLS ━━━━━◇"
echo -e "OpenSSH	:955,465"
echo -e "Dropbear	:80,944,587"
echo -e "Ws Dropbear	:80,443"
echo -e "◇━━━━ Mode Proxy ━━━━━◇"
echo -e "OHP OpenSSH	:8080"
echo -e "OHP Dropbear	:8181"
echo -e "OHP OpenVPN	:8282"
echo -e "Squid	:3128"
echo -e "Socks5	:1080"
echo -e "◇━━━━ Slow DNS ━━━━━◇"
echo -e "NS SlowDNS     : $nsdomain"
echo -e "Port SlowDNS	:22/OR Any Port"
echo -e "Pubkey SlowDNS : $pubkey"
echo -e "◇━━━━━ OpenVPN ━━━━━◇"
echo -e "Port TCP OpenVPN :80,443"
echo -e "Port UDP OpenVPN :80,443,2200"
echo -e "Port SSL OpenVPN :443,995"
echo -e "Config OpenVPN.  : http://"$domain":81/ovpngen.html"
echo -e "Conf All OpenVPN : http://"$domain":81/confopenvpn-all.zip"

echo -e "TCP Non SSL/TLS: http://"$domain":81/tcp-1194.ovpn"
echo -e "TCP SSL/TLS: http://"$domain":81/tcpssl-995.ovpn"
echo -e "UDP SSL/TLS: http://"$domain":81/udp-2200.ovpn"
echo -e "◇━━━━━━━━━━━━━━━━━◇"
echo -e "UDPcustom	:1-65535"
echo -e "BadVPN/UDPGW	:7200,7300"
echo -e "Reboot VPS	: 00.05 ()"
echo -e "◇━━━━━━━━━━━━━━━━━◇"
echo -e "GET / HTTP/1.1[crlf]Host: [host][crlf]User-Agent: [ua][crlf]Upgrade: websocket[crlf][crlf]"
echo -e "\n◇━━━━━━━━━━━━━━━━━◇"
read -p "To back to MENU press [ENTER]..."
/usr/sbin/menu
