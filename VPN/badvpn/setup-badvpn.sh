#!/bin/bash
# installer badvpn

wget -O /usr/bin/badvpn-udpgw "https://github.com/lamtota40/vpn-server-easy/raw/main/VPN/badvpn/badvpn-udpgw64"
chmod +x /usr/bin/badvpn-udpgw

for (( x=1; x<=3; x++ ))
do 
  cat > /etc/systemd/system/svr-7300.service <<-END
[Unit]
Description=badvpn udpgw 7300
After=network.target nss-lookup.target

[Service]
Type=simple
User=root
CapabilityBoundingSet=CAP_NET_ADMIN CAP_NET_BIND_SERVICE
AmbientCapabilities=CAP_NET_ADMIN CAP_NET_BIND_SERVICE
NoNewPrivileges=true
Restart=on-failure
ExecStart=/usr/bin/badvpn-udpgw --listen-addr 127.0.0.1:7300 --max-clients 500

[Install]
WantedBy=multi-user.target
END
chmod +x /etc/systemd/system/svr-7300.service

systemctl daemon-reload
systemctl start svr-7300.service
systemctl enable svr-7300.service
systemctl restart svr-7300.service
done

rm -rf setup-dropbear.sh
