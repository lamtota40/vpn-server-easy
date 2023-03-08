#!/bin/bash
# installer badvpn

wget -O /usr/bin/badvpn-udpgw "https://github.com/lamtota40/vpn-server-easy/raw/main/VPN/badvpn/badvpn-udpgw64"
chmod +x /usr/bin/badvpn-udpgw
systemctl daemon-reload

port1=7200
port2=7300

for (( x=1; x<=2; x++ ))
do 
  xport="port$x"
  cat > /etc/systemd/system/svr-$xport.service <<-END
[Unit]
Description=badvpn udpgw $xport
After=network.target nss-lookup.target

[Service]
Type=simple
User=root
CapabilityBoundingSet=CAP_NET_ADMIN CAP_NET_BIND_SERVICE
AmbientCapabilities=CAP_NET_ADMIN CAP_NET_BIND_SERVICE
NoNewPrivileges=true
Restart=on-failure
ExecStart=/usr/bin/badvpn-udpgw --listen-addr 127.0.0.1:$xport --max-clients 500

[Install]
WantedBy=multi-user.target
END
chmod +x /etc/systemd/system/svr-$xport.service

systemctl start svr-$xport.service
systemctl enable svr-$xport.service
done

rm -rf setup-badvpn.sh
