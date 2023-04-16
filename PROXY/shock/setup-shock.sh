#!/bin/bash

apt install dante-server -y
wget -O /etc/danted.conf https://raw.githubusercontent.com/lamtota40/vpn-server-easy/main/PROXY/shock/danted.conf
systemctl restart danted
systemctl enable danted

rm -rf setup-dropbear.sh
