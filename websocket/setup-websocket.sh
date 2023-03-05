#!/bin/bash

apt install python -y
curl -skL -o /usr/local/sbin/startnoload "https://raw.githubusercontent.com/lamtota40/vpn-server-easy/main/websocket/startnoload" 
chmod +x /usr/local/sbin/startnoload
