#!/bin/bash

cd
mkdir -p /root/myvpn/udp

# change to time GMT+7
#ln -fs /usr/share/zoneinfo/Asia/Jakarta /etc/localtime

# install udp-custom
wget -O /root/myvpn/udp/udp-custom "https://raw.githubusercontent.com/lamtota40/vpn-server-easy/main/UDPcustom/udp-custom-linux-amd64"
chmod +x /root/myvpn/udp/udp-custom

wget -O /root/myvpn/udp/config.json "https://raw.githubusercontent.com/lamtota40/vpn-server-easy/main/UDPcustom/config.json"
chmod 644 /root/myvpn/udp/config.json

if [ -z "$1" ]; then
cat <<EOF > /etc/systemd/system/udp-custom.service
[Unit]
Description=udp-custom by ePro Dev. Team

[Service]
User=root
Type=simple
ExecStart=/root/myvpn/udp/udp-custom server
WorkingDirectory=/root/myvpn/udp/
Restart=always
RestartSec=2s

[Install]
WantedBy=default.target
EOF
else
cat <<EOF > /etc/systemd/system/udp-custom.service
[Unit]
Description=udp-custom by ePro Dev. Team

[Service]
User=root
Type=simple
ExecStart=/root/myvpn/udp/udp-custom server -exclude $1
WorkingDirectory=/root/myvpn/udp/
Restart=always
RestartSec=2s

[Install]
WantedBy=default.target
EOF
fi

systemctl start udp-custom &>/dev/null
systemctl enable udp-custom &>/dev/null

rm -rf setup-UDPcustom.sh
