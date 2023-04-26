#!/bin/bash

mkdir myvpn/cron
site="https://raw.githubusercontent.com/lamtota40/vpn-server-easy/main"
wget -O /root/myvpn/listusers.sh $site/tools/listusers.sh && chmod +x listusers.sh
wget -O /root/myvpn/adduser $site/tools/adduser.sh && chmod +x adduser
wget -O /root/myvpn/speedtest $site/tools/speedtest_cli.py && chmod +x speedtest
wget -O /root/myvpn/ram $site/tools/ram.sh && chmod +x ram
wget -O /root/myvpn/detailserver.h $site/tools/detailserver.sh && chmod +x /root/myvpn/detailserver.sh
rm -rf setup-tools.sh
