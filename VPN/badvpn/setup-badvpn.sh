#!/bin/bash
# installer badvpn

wget -O /usr/bin/badvpn-udpgw "https://github.com/lamtota40/vpn-server-easy/raw/main/VPN/badvpn/badvpn-udpgw64"
chmod +x /usr/bin/badvpn-udpgw

#system badvpn 7300
wget -O /etc/systemd/system/svr-7300.service https://raw.githubusercontent.com/hidessh99/projectku/main/badvpn/svr-7300.service && chmod +x  /etc/systemd/system/svr-7300.service
#system badvpn 7200
wget -O /etc/systemd/system/svr-7200.service https://raw.githubusercontent.com/hidessh99/projectku/main/badvpn/svr-7200.service && chmod +x  /etc/systemd/system/svr-7200.service
#system badvpn 7100
wget -O /etc/systemd/system/svr-7100.service https://raw.githubusercontent.com/hidessh99/projectku/main/badvpn/svr-7100.service && chmod +x  /etc/systemd/system/svr-7100.service

#reboot system 7100
systemctl daemon-reload
systemctl start svr-7100.service
systemctl enable svr-7100.service
systemctl restart svr-7100.service

#reboot system 7200
systemctl daemon-reload
systemctl start svr-7200.service
systemctl enable svr-7200.service
systemctl restart svr-7200.service

#reboot system 7300
systemctl daemon-reload
systemctl start svr-7300.service
systemctl enable svr-7300.service
systemctl restart svr-7300.service

rm -rf setup-dropbear.sh
