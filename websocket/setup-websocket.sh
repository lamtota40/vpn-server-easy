#!/bin/bash

if [ ! $(which python) ]; then
   apt install python -y
fi

#instalasi Websocket (accept http port 2052 forward to port 1194[OpenVPN])
wget -O /usr/local/bin/ws-openvpn2052 https://raw.githubusercontent.com/lamtota40/vpn-server-easy/main/websocket/ws-openvpn2052.py && chmod +x /usr/local/bin/ws-openvpn2052

cat > /etc/systemd/system/ws-openvpn2052.service <<-END
[Unit]
Description=HTTP Websocket Over OpenVPN 2052 Python
Documentation=https://github.com/lamtota40
After=network.target nss-lookup.target

[Service]
Type=simple
User=root
CapabilityBoundingSet=CAP_NET_ADMIN CAP_NET_BIND_SERVICE
AmbientCapabilities=CAP_NET_ADMIN CAP_NET_BIND_SERVICE
NoNewPrivileges=true
Restart=on-failure
ExecStart=/usr/bin/python -O /usr/local/bin/ws-openvpn2052

[Install]
WantedBy=multi-user.target
END
chmod +x /etc/systemd/system/ws-openvpn2052.service
###################################################
#instalasi Websocket (accept http port 2082 forward to port 22[OpenSSH])
wget -O /usr/local/bin/ws-ssh2082 https://raw.githubusercontent.com/lamtota40/vpn-server-easy/main/websocket/ws-ssh2082.py && chmod +x /usr/local/bin/ws-ssh2082

cat > /etc/systemd/system/ws-ssh2082.service <<-END
[Unit]
Description=HTTP Websocket Over SSH 2082 Python
Documentation=https://github.com/lamtota40
After=network.target nss-lookup.target

[Service]
Type=simple
User=root
CapabilityBoundingSet=CAP_NET_ADMIN CAP_NET_BIND_SERVICE
AmbientCapabilities=CAP_NET_ADMIN CAP_NET_BIND_SERVICE
NoNewPrivileges=true
Restart=on-failure
ExecStart=/usr/bin/python -O /usr/local/bin/ws-ssh2082

[Install]
WantedBy=multi-user.target
END
chmod +x /etc/systemd/system/ws-dropbear8880.service
###################################################
wget -O /usr/local/bin/ws-ssh2082 https://raw.githubusercontent.com/lamtota40/vpn-server-easy/main/websocket/ws-ssh2082.py && chmod +x /usr/local/bin/ws-ssh2082

cat > /etc/systemd/system/ws-ssh2082.service <<-END
[Unit]
Description=HTTP Websocket 2082 over OpenSSH 22 Python
Documentation=https://github.com/lamtota40
After=network.target nss-lookup.target

[Service]
Type=simple
User=root
CapabilityBoundingSet=CAP_NET_ADMIN CAP_NET_BIND_SERVICE
AmbientCapabilities=CAP_NET_ADMIN CAP_NET_BIND_SERVICE
NoNewPrivileges=true
Restart=on-failure
ExecStart=/usr/bin/python -O /usr/local/bin/ws-ssh2082

[Install]
WantedBy=multi-user.target
END
chmod +x /etc/systemd/system/ws-ssh2082.service
##################################################
systemctl daemon-reload
systemctl enable ws-openvpn82.service
systemctl start ws-openvpn82.service
systemctl restart ws-openvpn82.service

systemctl enable ws-http2082.service
systemctl start ws-http2082.service
systemctl restart ws-http2082.service

systemctl enable ws-http8880.service
systemctl start ws-http8880.service
systemctl restart ws-http8880.service

rm -rf setup-websocket.sh
