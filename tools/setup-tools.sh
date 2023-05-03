#!/bin/bash

site="https://raw.githubusercontent.com/lamtota40/vpn-server-easy/main"
wget -O /root/myvpn/adduser $site/tools/adduser.sh && chmod +x /root/myvpn/adduser
wget -O /root/myvpn/addudp $site/tools/addudp.sh && chmod +x /root/myvpn/addudp
wget -O /root/myvpn/listusers.sh $site/tools/listusers.sh && chmod +x /root/myvpn/listusers.sh
wget -O /root/myvpn/speedtest $site/tools/speedtest_cli.py && chmod +x /root/myvpn/speedtest
wget -O /root/myvpn/ram $site/tools/ram.sh && chmod +x /root/myvpn/ram
wget -O /root/myvpn/detailserver.sh $site/tools/detailserver.sh && chmod +x /root/myvpn/detailserver.sh
wget -O /root/myvpn/whologin $site/tools/whologin.sh && chmod +x /root/myvpn/whologin

rm -rf setup-tools.sh
