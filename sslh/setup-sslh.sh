#!/bin/bash

#apt-get install sslh -y
apt-get install sslh --no-install-recommends -y
#port 333 to 44 and 777
wget -O /etc/default/sslh "https://raw.githubusercontent.com/lamtota40/vpn-server-easy/main/sslh/sslh.conf"
service sslh restart

rm -rf setup-sslh.sh


