#!/bin/bash

site="https://raw.githubusercontent.com/lamtota40/vpn-server-easy/main"
wget -O myvpn/adduser $site/tools/adduser.sh && chmod +x adduser
wget -O myvpn/speedtest $site/tools/speedtest_cli.py && chmod +x speedtest
wget -O myvpn/ram $site/tools/ram.sh && chmod +x ram
rm -rf setup-tools.sh
