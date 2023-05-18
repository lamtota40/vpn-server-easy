#!/bin/bash

cd
mkdir -p /etc/udpc

# download udp-custom
wget -O /etc/udpc/udp-custom https://raw.githubusercontent.com/lamtota40/vpn-server-easy/main/UDPcustom/udp-custom
chmod +x /etc/udpc/udp-custom

# download config.json
wget -O /etc/udpc/config.json https://raw.githubusercontent.com/lamtota40/vpn-server-easy/main/UDPcustom/config.json
chmod 644 /etc/udpc/config.json

#port not listen UDPcustom for slowdns&openvpn
notlisten="53,2200,5300"

cat <<EOF > /etc/systemd/system/udpcustom.service
[Unit]
Description=UDP Custom by ePro Dev. Team

[Service]
User=root
Type=simple
ExecStart=/etc/udpc/udp-custom server -exclude $notlisten
WorkingDirectory=/etc/udpc
Restart=always
RestartSec=2s

[Install]
WantedBy=default.target
EOF

echo start service udpcustom
systemctl start udpcustom &>/dev/null

echo enable service udpcustom
systemctl enable udpcustom &>/dev/null
rm -rf setup-UDPcustom.sh
