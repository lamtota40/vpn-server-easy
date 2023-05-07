#!/bin/sh

#for UDPGW port 7200
cat <<EOF > /etc/systemd/system/udpgw7200.service
[Unit]
Description=udpgw 7200
After=network.target nss-lookup.target

[Service]
Type=simple
User=root
CapabilityBoundingSet=CAP_NET_ADMIN CAP_NET_BIND_SERVICE
AmbientCapabilities=CAP_NET_ADMIN CAP_NET_BIND_SERVICE
NoNewPrivileges=true
Restart=on-failure
ExecStart=/usr/bin/udpgw --listen-addr 127.0.0.1:7200 --max-clients 500

[Install]
WantedBy=multi-user.target
EOF
chmod +x /etc/systemd/system/udpgw7200.service

#for UDPGW port 7300
cat <<EOF > /etc/systemd/system/udpgw7300.service
[Unit]
Description=udpgw 7300
After=network.target nss-lookup.target

[Service]
Type=simple
User=root
CapabilityBoundingSet=CAP_NET_ADMIN CAP_NET_BIND_SERVICE
AmbientCapabilities=CAP_NET_ADMIN CAP_NET_BIND_SERVICE
NoNewPrivileges=true
Restart=on-failure
ExecStart=/usr/bin/udpgw --listen-addr 127.0.0.1:7300 --max-clients 500

[Install]
WantedBy=multi-user.target
EOF
chmod +x /etc/systemd/system/udpgw7300.service

systemctl daemon-reload
systemctl start udpgw7200.service
systemctl enable udpgw7200.service
systemctl start udpgw7300.service
systemctl enable udpgw7300.service
