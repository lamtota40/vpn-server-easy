#!/bin/bash

if [ ! $(which sshd) ]; then
    stat="Not Instaled"
else
    stat="Already Instaled"
fi


echo "Status :$stat"
apt install dropbear -y
cp /etc/default/dropbear /etc/default/dropbear.bak
wget -P /etc https://raw.githubusercontent.com/lamtota40/vpn-server-easy/main/tools/other/issue.ssh

default_port= "80"
extra_port= "-p 144 -p 8080"

sed -i -e 's/NO_START=1/NO_START=0/g' /etc/default/dropbear
sed -i -e 's/DROPBEAR_PORT=22/DROPBEAR_PORT=443/g' /etc/default/dropbear
sed -i -e 's/DROPBEAR_EXTRA_ARGS=/DROPBEAR_EXTRA_ARGS="-p 80 -p 8080"/g' /etc/default/dropbear
sed -i -e 's/DROPBEAR_BANNER=/DROPBEAR_BANNER="/etc/issue.ssh"/g' /etc/default/dropbear

systemctl enable dropbear
systemctl restart dropbear

#unistall
#sudo apt-get purge dropbear -y
