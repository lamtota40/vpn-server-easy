#!/bin/bash

apt install stunnel4 -y
curl -skL "https://raw.githubusercontent.com/lamtota40/vpn-server-easy/main/SSH/stunel4/stunnel.conf" -o /etc/stunnel/stunnel.conf
curl -skL "https://raw.githubusercontent.com/lamtota40/vpn-server-easy/main/SSH/stunel4/stunnel.pem" -o /etc/stunnel/stunnel.pem
sed -i 's/ENABLED=0/ENABLED=1/g' /etc/default/stunnel4
systemctl restart stunnel4

if ! systemctl status stunnel4 &> /dev/null; then
   printf "\nFailed to install Stunnel4\n" && err
fi

rm -rf setup-stunnel4.sh
