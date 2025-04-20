#!/bin/bash

# COLOR VALIDATION
RED='\033[0;31m'
NC='\033[0m'
GREEN='\033[0;32m'
CYAN='\033[0;96m'

# Fungsi untuk cek status service
cek_status() {
    local service_name=$1
    local status=$(systemctl is-active "$service_name")

    if [[ $status == "active" ]]; then
        echo -e "${GREEN}Running${NC} ( No Error )"
    else
        echo -e "${RED}Not Running${NC} ( Error )"
    fi
}

# Panggil fungsi untuk tiap service
sopenssh=$(cek_status ssh)
sdropbear=$(cek_status dropbear)
sws8880=$(cek_status ws-dropbear8880.service)
sopenvpn=$(cek_status openvpn)
sopenvpntcp=$(cek_status openvpn-server@server-tcp-1194.service)
sopenvpnudp=$(cek_status openvpn-server@server-udp-2200.service)
ssquid=$(cek_status squid)
scron=$(cek_status cron)
snginx=$(cek_status nginx)

svnstat=$(cek_status vnstat)
sdanted=$(cek_status danted)
sstunnel=$(cek_status stunnel4)
ssslh=$(cek_status sslh)

sohq=$(cek_status ohp-openvpn.service)
sohr=$(cek_status ohp-ssh.service)


clear

echo -e "${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m${NC}"
echo -e "\E[41;1;39m            ⇱ Service Information ⇲             \E[0m"
echo -e "${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m${NC}"
echo -e "⚙️ Open SSH                :$sopenssh"
echo -e "⚙️ Dropbear                :$sdropbear"
echo -e "⚙️ Websocket               :$sws8880"
echo -e "⚙️ Slow DNS                :$sopenssh"
echo -e "⚙️ UDP Custom              :$sopenssh"
echo -e "⚙️ OpenVPN                 :$sopenvpn"
echo -e "⚙️ OpenVPN TCP 1194        :$sopenvpntcp"
echo -e "⚙️ OpenVPN UDP 2200        :$sopenvpnudp"
echo -e "⚙️ BadVPN/UDPGW            :$sopenssh"
echo -e "⚙️ Stunnel4 (SSL)          :$sstunnel"
echo -e "⚙️ OHP                     :$sopenssh"
echo -e "⚙️ OHP Dropbear            :$sopenssh"
echo -e "⚙️ OHP Openvpn             :$sopenssh"
echo -e "⚙️ Danted (Proxy Socks)    :$sdanted"
echo -e "⚙️ Squid (Proxy HTTP/S)    :$ssquid"
echo -e "⚙️ XRAYS Vmess TLS         :$sopenssh"
echo -e "⚙️ XRAYS Vmess None TLS    :$sopenssh"
echo -e "⚙️ XRAYS Vless TLS         :$sopenssh"
echo -e "⚙️ XRAYS Vless None TLS    :$sopenssh"
echo -e "⚙️ Shadowsocks-R           :$sopenssh"
echo -e "⚙️ Shadowsocks-OBFS HTTPS  :$sopenssh"
echo -e "⚙️ Shadowsocks-OBFS HTTP   :$sopenssh"
echo -e "⚙️ XRAYS Trojan            :$sopenssh"
echo -e "⚙️ SSLH                    :$ssslh"
echo -e "⚙️ Nginx                   :$snginx"
echo -e "⚙️ Fail2Ban                :$sopenssh"
echo -e "⚙️ Cron                    :$scron"
echo -e "⚙️ Vnstat                  :$svnstat"
echo -e "${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m${NC}"
echo ""
read -n 1 -s -r -p "Back to Menu Press Enter...."

menu
