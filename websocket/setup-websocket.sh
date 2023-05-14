#!/bin/bash

if [ ! $(which python) ]; then
   apt install python -y
fi

#instalasi Websocket (accept http port 2082 forward to port 23[dropbear])
wget -O /usr/local/bin/ws-http2082 https://raw.githubusercontent.com/lamtota40/vpn-server-easy/main/websocket/ws-http2082.py && chmod +x /usr/local/bin/ws-http2082

cat > /etc/systemd/system/ws-http2082.service <<-END
[Unit]
Description=HTTP SSH Over Websocket 2082 Python
Documentation=https://github.com/lamtota40
After=network.target nss-lookup.target

[Service]
Type=simple
User=root
CapabilityBoundingSet=CAP_NET_ADMIN CAP_NET_BIND_SERVICE
AmbientCapabilities=CAP_NET_ADMIN CAP_NET_BIND_SERVICE
NoNewPrivileges=true
Restart=on-failure
ExecStart=/usr/bin/python -O /usr/local/bin/ws-http2082

[Install]
WantedBy=multi-user.target
END
chmod +x /etc/systemd/system/ws-http2082.service
###################################################
#instalasi Websocket (accept http port 8880 forward to port 23[dropbear])
wget -O /usr/local/bin/ws-http8880 https://raw.githubusercontent.com/lamtota40/vpn-server-easy/main/websocket/ws-http8880.py && chmod +x /usr/local/bin/ws-http8880

cat > /etc/systemd/system/ws-http8880.service <<-END
[Unit]
Description=HTTP SSH Over Websocket 8880 Python
Documentation=https://github.com/lamtota40
After=network.target nss-lookup.target

[Service]
Type=simple
User=root
CapabilityBoundingSet=CAP_NET_ADMIN CAP_NET_BIND_SERVICE
AmbientCapabilities=CAP_NET_ADMIN CAP_NET_BIND_SERVICE
NoNewPrivileges=true
Restart=on-failure
ExecStart=/usr/bin/python -O /usr/local/bin/ws-http8880

[Install]
WantedBy=multi-user.target
END
chmod +x /etc/systemd/system/ws-http8880.service
##################################################
systemctl daemon-reload
systemctl enable ws-http2082.service
systemctl start ws-http2082.service
systemctl restart ws-http2082.service

systemctl enable ws-http8880.service
systemctl start ws-http8880.service
systemctl restart ws-http8880.service

rm -rf setup-websocket.sh
