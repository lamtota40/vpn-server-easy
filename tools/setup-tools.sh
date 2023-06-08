#!/bin/bash

site="https://raw.githubusercontent.com/lamtota40/vpn-server-easy/main"
wget -O /root/myvpn/addusers $site/tools/addusers.sh && chmod +x /root/myvpn/addusers
wget -O /root/myvpn/listusers $site/tools/listusers.sh && chmod +x /root/myvpn/listusers
wget -O /root/myvpn/speedtest $site/tools/speedtest_cli.py && chmod +x /root/myvpn/speedtest
wget -O /root/myvpn/ram $site/tools/ram.sh && chmod +x /root/myvpn/ram
wget -O /root/myvpn/detailserver $site/tools/detailserver.sh && chmod +x /root/myvpn/detailserver
wget -O /root/myvpn/whoislogin $site/tools/whoislogin.sh && chmod +x /root/myvpn/whoislogin
wget -O /root/myvpn/smanager $site/tools/smanager.sh && chmod +x /root/myvpn/smanager
wget -O /root/myvpn/xray/addvmess $site/tools/m-xray/addvmess.sh && chmod +x /root/myvpn/xray/addvmess
wget -O /root/myvpn/xray/addvless $site/tools/m-xray/addvmess.sh && chmod +x /root/myvpn/xray/addvless

rm -rf setup-tools.sh
