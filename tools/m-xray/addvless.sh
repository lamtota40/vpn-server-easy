#!/bin/bash
# Jagoanneon
# ==========================================
# Color
RED='\033[0;31m'
NC='\033[0m'
GREEN='\033[0;32m'
ORANGE='\033[0;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
LIGHT='\033[0;37m'
# ==========================================
# Getting
MYIP=$(wget -qO- ipinfo.io/ip);
echo "Checking VPS"

IZIN=$( curl https://raw.githubusercontent.com/godtrex99/ip/main/ipvps | grep $MYIP )

if [ $MYIP = $IZIN ]; then
echo -e "${GREEN}Akses Di Izinkan...${NC}"
else
echo -e "${RED}VPS tidak diijinkan${NC}";
echo "Kontak Admin Untuk Mendapatkan Akses Script"
echo "Facebook   : Generasi Jvg Tuban"
echo "WhatsApp   : 083857684916"
exit 0
fi
clear
source /var/lib/crot/ipvps.conf
if [[ "$IP" = "" ]]; then
domain=$(cat /etc/xray/domain)
else
domain=$IP
fi
read -rp "Masukkan Bug: " -e bug
tls="$(cat ~/log-install.txt | grep -w "Vless TLS" | cut -d: -f2|sed 's/ //g')"
nontls="$(cat ~/log-install.txt | grep -w "Vless None TLS" | cut -d: -f2|sed 's/ //g')"
until [[ $user =~ ^[a-zA-Z0-9_]+$ && ${CLIENT_EXISTS} == '0' ]]; do
		read -rp "Username : " -e user
		CLIENT_EXISTS=$(grep -w $user /etc/xray/config.json | wc -l)

		if [[ ${CLIENT_EXISTS} == '1' ]]; then
			echo ""
			echo -e "Username ${RED}${user}${NC} Already On VPS Please Choose Another"
			exit 1
		fi
	done
uuid=$(cat /proc/sys/kernel/random/uuid)
read -p "Expired (Days) : " masaaktif
hariini=`date -d "0 days" +"%Y-%m-%d"`
exp=`date -d "$masaaktif days" +"%Y-%m-%d"`
sed -i '/#xray-vless-tls$/a\#### '"$user $exp"'\
},{"id": "'""$uuid""'","email": "'""$user""'"' /etc/xray/config.json
sed -i '/#xray-vless-nontls$/a\#### '"$user $exp"'\
},{"id": "'""$uuid""'","email": "'""$user""'"' /etc/xray/config.json
sed -i '/#vlessgrpc$/a\#### '"$user $exp"'\
},{"id": "'""$uuid""'","email": "'""$user""'"' /etc/xray/vlessgrpc.json
xrayvless1="vless://${uuid}@${domain}:$tls?path=/Jvg&security=tls&encryption=none&type=ws#${user}"
xrayvless2="vless://${uuid}@${domain}:$nontls?path=/Jvg&encryption=none&type=ws#${user}"
xrayvless3="vless://${uuid}@${domain}:2080?mode=multi&security=tls&encryption=none&type=grpc&serviceName=GunService&sni=${bug}#$user"
systemctl restart xray.service
service cron restart
clear
echo -e ""
echo -e "═══════════════════════" | lolcat
echo -e "${RED}====-XRAYS/VLESS-====${NC}" | lolcat
echo -e "═══════════════════════" | lolcat
echo -e "Remarks     : ${user}" | lolcat
echo -e "IP/Host     : ${MYIP}" | lolcat
echo -e "Address     : ${domain}" | lolcat
echo -e "Port TLS    : $tls" | lolcat
echo -e "Port No TLS : $nontls" | lolcat
echo -e "Port GRPC   : 2080" | lolcat
echo -e "User ID     : ${uuid}" | lolcat
echo -e "Encryption  : none" | lolcat
echo -e "Network     : WS & Grpc" | lolcat
echo -e "Mode        : Multi" | lolcat
echo -e "SecurityGRPC: TLS" | lolcat
echo -e "Type        : GRPC" | lolcat
echo -e "Bug.        : ${bug}" | lolcat
echo -e "Path        : /Jvg" | lolcat
echo -e "═══════════════════════" | lolcat
echo -e "Link TLS    : " | lolcat
echo -e ""
echo -e " ${xrayvless1}" | lolcat
echo -e "════════════════" | lolcat
echo -e "Link No TLS : " | lolcat
echo -e ""
echo -e " ${xrayvless2}" | lolcat
echo -e "════════════════" | lolcat
echo -e "Link No GRPC : " | lolcat
echo -e ""
echo -e " ${xrayvless3}" | lolcat
echo -e "═══════════════════════" | lolcat
echo -e "Created     : $hariini" | lolcat
echo -e "Expired     : $exp" | lolcat
echo -e "═══════════════════════" | lolcat
echo -e "${RED}AutoScriptSSH By Jvg${NC}"
echo -e "═══════════════════════" | lolcat
echo -e""
read -p "Ketik Enter Untuk Kembali Ke Menu...."
sleep 1
menu
exit 0
fi
