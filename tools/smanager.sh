#!/bin/bash

red='\e[1;31m'
green='\e[0;32m'
yell='\e[1;33m'
tyblue='\e[1;36m'
NC='\e[0m'
purple() { echo -e "\\033[35;1m${*}\\033[0m"; }
tyblue() { echo -e "\\033[36;1m${*}\\033[0m"; }
yellow() { echo -e "\\033[33;1m${*}\\033[0m"; }
green() { echo -e "\\033[32;1m${*}\\033[0m"; }
red() { echo -e "\\033[31;1m${*}\\033[0m"; }

# COLOR VALIDATION
RED='\033[0;31m'
NC='\033[0m'
GREEN='\033[0;32m'
ORANGE='\033[0;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
LIGHT='\033[0;37m'

x="ok"

cekray=`cat /root/log-install.txt | grep -ow "XRAY" | sort | uniq`
if [ "$cekray" = "XRAY" ]; then
rekk='XRAY'
bec='xray'
else
rekk='V2RAY'
bec='v2ray'
fi

clear
#GETTING OS INFORMATION
source /etc/os-release
Versi_OS=$VERSION
ver=$VERSION_ID
URL_SUPPORT=$HOME_URL
basedong=$ID

# CHEK STATUS 
l2tp_status=$(systemctl status xl2tpd | grep Active | awk '{print $3}' | cut -d "(" -f2 | cut -d ")" -f1)
openvpn_service="$(systemctl show openvpn.service --no-page)"
oovpn=$(echo "${openvpn_service}" | grep 'ActiveState=' | cut -f2 -d=)
#status_openvp=$(/etc/init.d/openvpn status | grep Active | awk '{print $3}' | cut -d "(" -f2 | cut -d ")" -f1)
#status_ss_tls="$(systemctl show shadowsocks-libev-server@tls.service --no-page)"
#ss_tls=$(echo "${status_ss_tls}" | grep 'ActiveState=' | cut -f2 -d=)
sst_status=$(systemctl status shadowsocks-libev-server@tls | grep Active | awk '{print $3}' | cut -d "(" -f2 | cut -d ")" -f1) 
ssh_status=$(systemctl status shadowsocks-libev-server@http | grep Active | awk '{print $3}' | cut -d "(" -f2 | cut -d ")" -f1) 
#status_ss_http="$(systemctl show shadowsocks-libev-server@http.service --no-page)"
#ss_http=$(echo "${status_ss_http}" | grep 'ActiveState=' | cut -f2 -d=)
#sssohtt=$(systemctl status shadowsocks-libev-server@*-http | grep Active | awk '{print $3}' | cut -d "(" -f2 | cut -d ")" -f1)
#status="$(systemctl show shadowsocks-libev.service --no-page)"
#status_text=$(echo "${status}" | grep 'ActiveState=' | cut -f2 -d=)
tls_v2ray_status=$(systemctl status xray | grep Active | awk '{print $3}' | cut -d "(" -f2 | cut -d ")" -f1)
nontls_v2ray_status=$(systemctl status xray | grep Active | awk '{print $3}' | cut -d "(" -f2 | cut -d ")" -f1)
vless_tls_v2ray_status=$(systemctl status xray | grep Active | awk '{print $3}' | cut -d "(" -f2 | cut -d ")" -f1)
vless_nontls_v2ray_status=$(systemctl status xray | grep Active | awk '{print $3}' | cut -d "(" -f2 | cut -d ")" -f1)
ssr_status=$(systemctl status ssrmu | grep Active | awk '{print $3}' | cut -d "(" -f2 | cut -d ")" -f1)
trojan_server=$(systemctl status xray | grep Active | awk '{print $3}' | cut -d "(" -f2 | cut -d ")" -f1)
dropbear_status=$(/etc/init.d/dropbear status | grep Active | awk '{print $3}' | cut -d "(" -f2 | cut -d ")" -f1)
stunnel_service=$(/etc/init.d/stunnel5 status | grep Active | awk '{print $3}' | cut -d "(" -f2 | cut -d ")" -f1)
sstp_service=$(systemctl status accel-ppp | grep Active | awk '{print $3}' | cut -d "(" -f2 | cut -d ")" -f1)
squid_service=$(/etc/init.d/squid status | grep Active | awk '{print $3}' | cut -d "(" -f2 | cut -d ")" -f1)
ssh_service=$(/etc/init.d/ssh status | grep Active | awk '{print $3}' | cut -d "(" -f2 | cut -d ")" -f1)
vnstat_service=$(/etc/init.d/vnstat status | grep Active | awk '{print $3}' | cut -d "(" -f2 | cut -d ")" -f1)
cron_service=$(/etc/init.d/cron status | grep Active | awk '{print $3}' | cut -d "(" -f2 | cut -d ")" -f1)
fail2ban_service=$(/etc/init.d/fail2ban status | grep Active | awk '{print $3}' | cut -d "(" -f2 | cut -d ")" -f1)
wg="$(systemctl show wg-quick@wg0.service --no-page)"
swg=$(echo "${wg}" | grep 'ActiveState=' | cut -f2 -d=)
trgo="$(systemctl show trojan-go.service --no-page)"                                      
strgo=$(echo "${trgo}" | grep 'ActiveState=' | cut -f2 -d=)  
sswg=$(systemctl status wg-quick@wg0 | grep Active | awk '{print $3}' | cut -d "(" -f2 | cut -d ")" -f1)
wstls=$(systemctl status ws-tls | grep Active | awk '{print $3}' | cut -d "(" -f2 | cut -d ")" -f1)
wsdrop=$(systemctl status ws-nontls | grep Active | awk '{print $3}' | cut -d "(" -f2 | cut -d ")" -f1)
wsovpn=$(systemctl status ws-ovpn | grep Active | awk '{print $3}' | cut -d "(" -f2 | cut -d ")" -f1)
#wsopen=$(systemctl status ws-openssh | grep Active | awk '{print $3}' | cut -d "(" -f2 | cut -d ")" -f1)
osslh=$(systemctl status sslh | grep Active | awk '{print $3}' | cut -d "(" -f2 | cut -d ")" -f1)
ohp=$(systemctl status dropbear-ohp | grep Active | awk '{print $3}' | cut -d "(" -f2 | cut -d ")" -f1)
ohq=$(systemctl status openvpn-ohp | grep Active | awk '{print $3}' | cut -d "(" -f2 | cut -d ")" -f1)
ohr=$(systemctl status ssh-ohp | grep Active | awk '{print $3}' | cut -d "(" -f2 | cut -d ")" -f1)

# STATUS SERVICE Shadowsocks HTTPS
if [[ $sst_status == "running" ]]; then
  status_sst=" ${GREEN}Running ${NC}( No Error )"
else
  status_sst="${RED}  Not Running ${NC}  ( Error )"
fi

# STATUS SERVICE Shadowsocks HTTP
if [[ $ssh_status == "running" ]]; then 
   status_ssh=" ${GREEN}Running ${NC}( No Error )"
else
   status_ssh="${RED}  Not Running ${NC}  ( Error )"
fi

# STATUS SERVICE OPENVPN
if [[ $oovpn == "active" ]]; then
  status_openvpn=" ${GREEN}Running ${NC}( No Error )"
else
  status_openvpn="${RED}  Not Running ${NC}  ( Error )"
fi

# STATUS SERVICE  SSH 
if [[ $ssh_service == "running" ]]; then 
   status_ssh=" ${GREEN}Running ${NC}( No Error )"
else
   status_ssh="${RED}  Not Running ${NC}  ( Error )"
fi

# STATUS SERVICE  SQUID 
if [[ $squid_service == "running" ]]; then 
   status_squid=" ${GREEN}Running ${NC}( No Error )"
else
   status_squid="${RED}  Not Running ${NC}  ( Error )"
fi

# STATUS SERVICE  VNSTAT 
if [[ $vnstat_service == "running" ]]; then 
   status_vnstat=" ${GREEN}Running ${NC}( No Error )"
else
   status_vnstat="${RED}  Not Running ${NC}  ( Error )"
fi

# STATUS SERVICE  CRONS 
if [[ $cron_service == "running" ]]; then 
   status_cron=" ${GREEN}Running ${NC}( No Error )"
else
   status_cron="${RED}  Not Running ${NC}  ( Error )"
fi

# STATUS SERVICE  FAIL2BAN 
if [[ $fail2ban_service == "running" ]]; then 
   status_fail2ban=" ${GREEN}Running ${NC}( No Error )"
else
   status_fail2ban="${RED}  Not Running ${NC}  ( Error )"
fi

# STATUS SERVICE  TLS 
if [[ $tls_v2ray_status == "running" ]]; then 
   status_tls_v2ray=" ${GREEN}Running${NC} ( No Error )"
else
   status_tls_v2ray="${RED}  Not Running${NC}   ( Error )"
fi

# STATUS SERVICE NON TLS V2RAY
if [[ $nontls_v2ray_status == "running" ]]; then 
   status_nontls_v2ray=" ${GREEN}Running ${NC}( No Error )${NC}"
else
   status_nontls_v2ray="${RED}  Not Running ${NC}  ( Error )${NC}"
fi

# STATUS SERVICE VLESS HTTPS
if [[ $vless_tls_v2ray_status == "running" ]]; then
  status_tls_vless=" ${GREEN}Running${NC} ( No Error )"
else
  status_tls_vless="${RED}  Not Running ${NC}  ( Error )${NC}"
fi

# STATUS SERVICE VLESS HTTP
if [[ $vless_nontls_v2ray_status == "running" ]]; then
  status_nontls_vless=" ${GREEN}Running${NC} ( No Error )"
else
  status_nontls_vless="${RED}  Not Running ${NC}  ( Error )${NC}"
fi

# SHADOWSOCKSR STATUS
if [[ $ssr_status == "running" ]] ; then
  status_ssr=" ${GREEN}Running${NC} ( No Error )${NC}"
else
  status_ssr="${RED}  Not Running ${NC}  ( Error )${NC}"
fi

# SODOSOK
if [[ $status_text == "active" ]] ; then
  status_sodosok=" ${GREEN}Running${NC} ( No Error )${NC}"
else
  status_sodosok="${RED}  Not Running ${NC}  ( Error )${NC}"
fi

# STATUS SERVICE TROJAN
if [[ $trojan_server == "running" ]]; then 
   status_virus_trojan=" ${GREEN}Running ${NC}( No Error )${NC}"
else
   status_virus_trojan="${RED}  Not Running ${NC}  ( Error )${NC}"
fi

# STATUS SERVICE WIREGUARD
if [[ $swg == "active" ]]; then
  status_wg=" ${GREEN}Running ${NC}( No Error )${NC}"
else
  status_wg="${RED}  Not Running ${NC}  ( Error )${NC}"
fi

# Status Service Trojan GO
if [[ $strgo == "active" ]]; then
  status_trgo=" ${GREEN}Running ${NC}( No Error )${NC}"
else
  status_trgo="${RED}  Not Running ${NC}  ( Error )${NC}"
fi

# STATUS SERVICE L2TP
if [[ $l2tp_status == "running" ]]; then 
   status_l2tp=" ${GREEN}Running${NC} ( No Error )${NC}"
else
   status_l2tp="${RED}  Not Running${NC}  ( Error )${NC}"
fi

# STATUS SERVICE DROPBEAR
if [[ $dropbear_status == "running" ]]; then 
   status_beruangjatuh=" ${GREEN}Running${NC} ( No Error )${NC}"
else
   status_beruangjatuh="${RED}  Not Running ${NC}  ( Error )${NC}"
fi

# STATUS SERVICE STUNNEL
if [[ $stunnel_service == "running" ]]; then 
   status_stunnel=" ${GREEN}Running ${NC}( No Error )"
else
   status_stunnel="${RED}  Not Running ${NC}  ( Error )}"
fi

# STATUS SERVICE SSTP
if [[ $sstp_service == "running" ]]; then 
   status_sstp=" ${GREEN}Running ${NC}( No Error )"
else
   status_sstp="${RED}  Not Running ${NC}  ( Error )"
fi

# STATUS SERVICE WEBSOCKET TLS
if [[ $wstls == "running" ]]; then 
   swstls=" ${GREEN}Running ${NC}( No Error )${NC}"
else
   swstls="${RED}  Not Running ${NC}  ( Error )${NC}"
fi

# STATUS SERVICE WEBSOCKET DROPBEAR
if [[ $wsdrop == "running" ]]; then 
   swsdrop=" ${GREEN}Running ${NC}( No Error )${NC}"
else
   swsdrop="${RED}  Not Running ${NC}  ( Error )${NC}"
fi

# STATUS SERVICE WEBSOCKET OPEN OVPN
if [[ $wsovpn == "running" ]]; then 
   swsovpn=" ${GREEN}Running ${NC}( No Error )${NC}"
else
   swsovpn="${RED}  Not Running ${NC}  ( Error )${NC}"
fi

# STATUS SERVICE SSLH / SSH
if [[ $osslh == "running" ]]; then 
   sosslh=" ${GREEN}Running ${NC}( No Error )${NC}"
else
   sosslh="${RED}  Not Running ${NC}  ( Error )${NC}"
fi

# STATUS OHP DROPBEAR
if [[ $ohp == "running" ]]; then 
   sohp=" ${GREEN}Running ${NC}( No Error )${NC}"
else
   sohp="${RED}  Not Running ${NC}  ( Error )${NC}"
fi

# STATUS OHP OpenVPN
if [[ $ohq == "running" ]]; then 
   sohq=" ${GREEN}Running ${NC}( No Error )${NC}"
else
   sohq="${RED}  Not Running ${NC}  ( Error )${NC}"
fi

# STATUS OHP SSH
if [[ $ohr == "running" ]]; then 
   sohr=" ${GREEN}Running ${NC}( No Error )${NC}"
else
   sohr="${RED}  Not Running ${NC}  ( Error )${NC}"
fi

# STATUS SERVICE WEBSOCKET OPENSSH
if [[ $wsopen == "running" ]]; then 
   swsopen=" ${GREEN}Running ${NC}( No Error )${NC}" 
else
   swsopen="${RED}  Not Running ${NC}  ( Error )${NC}"
fi

echo -e "${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m${NC}"
echo -e "\E[41;1;39m            ⇱ Service Information ⇲             \E[0m"
echo -e "${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m${NC}"
echo -e "⚙️ Websocket               :$status_ssh"
echo -e "⚙️ Open SSH                :$status_ssh"
echo -e "⚙️ Dropbear                :$status_beruangjatuh"
echo -e "⚙️ Slow DNS                :$status_ssh"
echo -e "⚙️ UDP Custom              :$status_ssh"
echo -e "⚙️ OpenVPN                 :$status_openvpn"
echo -e "⚙️ BadVPN/UDPGW            :$status_ssh"
echo -e "⚙️ Stunnel (SSL)           :$status_ssh"
echo -e "⚙️ OHP                     :$status_ssh"
echo -e "⚙️ Dante (Socks)           :$status_ssh"
echo -e "⚙️ Squid                   :$status_squid"
echo -e "⚙️ XRAYS Vmess TLS         :$status_tls_v2ray"
echo -e "⚙️ XRAYS Vmess None TLS    :$status_nontls_v2ray"
echo -e "⚙️ XRAYS Vless TLS         :$status_tls_vless"
echo -e "⚙️ XRAYS Vless None TLS    :$status_nontls_vless"
echo -e "⚙️ Shadowsocks-R           :$status_tls_vless"
echo -e "⚙️ Shadowsocks-OBFS HTTPS  :$status_tls_vless"
echo -e "⚙️ Shadowsocks-OBFS HTTP   :$status_tls_vless"
echo -e "⚙️ XRAYS Trojan            :$status_virus_trojan"
echo -e "⚙️ SSLH                    :$status_ssh"
echo -e "⚙️ Nginx                   :$status_ssh"
echo -e "⚙️ Fail2Ban                :$status_fail2ban"
echo -e "⚙️ Crons                   :$status_cron"
echo -e "⚙️ Vnstat                  :$status_vnstat"
echo -e "${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m${NC}"
echo ""
read -n 1 -s -r -p "Back to Menu Press Enter...."

menu
