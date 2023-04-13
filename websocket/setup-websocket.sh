#!/bin/bash

if [ ! $(which python) ]; then
   apt install python -y
fi

#instalasi Websocket (accept http port 80 to port 44[dropbear])
wget -O /usr/local/bin/ws-http https://raw.githubusercontent.com/lamtota40/vpn-server-easy/main/websocket/ws-http.py && chmod +x /usr/local/bin/ws-http

cat > /etc/systemd/system/ws-http.service <<-END
[Unit]
Description=HTTP SSH Over Websocket Python HideSSH
Documentation=https://hidessh.com
After=network.target nss-lookup.target

[Service]
Type=simple
User=root
CapabilityBoundingSet=CAP_NET_ADMIN CAP_NET_BIND_SERVICE
AmbientCapabilities=CAP_NET_ADMIN CAP_NET_BIND_SERVICE
NoNewPrivileges=true
Restart=on-failure
ExecStart=/usr/bin/python -O /usr/local/bin/ws-http

[Install]
WantedBy=multi-user.target
END
chmod +x /etc/systemd/system/ws-http.service

systemctl daemon-reload
systemctl enable ws-http.service
systemctl start ws-http.service
systemctl restart ws-http.service
