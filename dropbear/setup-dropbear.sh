#!/bin/bash

apt install dropbear -y
sudo cp /etc/default/dropbear /etc/default/dropbear.bak

sed -i -e 's/NO_START=1/NO_START=0/g' /etc/default/dropbear
nano /etc/default/dropbear

NO_START=0
DROPBEAR_EXTRA_ARGS="-p 109 -p 443 -p 143"

#sudo apt-get purge dropbear -y
