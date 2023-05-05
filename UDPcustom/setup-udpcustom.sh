#!/bin/bash

cd
rm -rf /root/udp
mkdir -p /root/udp

# change to time GMT+7
ln -fs /usr/share/zoneinfo/Asia/Jakarta /etc/localtime

# install udp-custom
wget -O /root/udp/udp-custom "https://raw.githubusercontent.com/lamtota40/vpn-server-easy/main/UDPcustom/udp-custom"
chmod +x /root/udp/udp-custom

#download config
wget -O /root/udp/config.json "https://raw.githubusercontent.com/lamtota40/vpn-server-easy/main/UDPcustom/config.json"
chmod 644 /root/udp/config.json

if [ -z "$1" ]; then
cat <<EOF > /etc/systemd/system/udp-custom.service
[Unit]
Description=UDP Custom by ePro Dev. Team

[Service]
User=root
Type=simple
ExecStart=/root/udp/udp-custom server
WorkingDirectory=/root/udp/
Restart=always
RestartSec=2s

[Install]
WantedBy=default.target
EOF
else
cat <<EOF > /etc/systemd/system/udp-custom.service
[Unit]
Description=UDP Custom by ePro Dev. Team

[Service]
User=root
Type=simple
ExecStart=/root/udp/udp-custom server -exclude $1
WorkingDirectory=/root/udp/
Restart=always
RestartSec=2s

[Install]
WantedBy=default.target
EOF
fi

systemctl enable udp-custom
systemctl start udp-custom
