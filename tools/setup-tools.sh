#!/bin/bash

site="https://raw.githubusercontent.com/lamtota40/vpn-server-easy/main"
wget -O myvpn/adduser $site/tools/adduser.sh && chmod +x adduser


rm -rf setup-vpn.sh
