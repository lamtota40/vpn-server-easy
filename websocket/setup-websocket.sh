#!/bin/bash

apt install python -y
curl -skL "https://raw.githubusercontent.com/lamtota40/vpn-server-easy/main/websocket/startnoload" -o /usr/local/sbin/startnoload
chmod +x /usr/local/sbin/startnoload
