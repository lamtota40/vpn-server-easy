#!/bin/bash

if [ ! $(which dropbear) ]; then
    stat="Not Instaled"
else
    stat="Already Instaled"
fi

#default_port= "80"
#extra_port= "-p 144 -p 8080"

echo "Status Dropbear :$stat"
apt install dropbear -y
cp /etc/default/dropbear /etc/default/dropbear.bak
sed -i "s/NO_START=.*/NO_START=0/" /etc/default/dropbear
sed -i "s/DROPBEAR_PORT=.*/DROPBEAR_PORT=80/" /etc/default/dropbear
sed -i 's/DROPBEAR_EXTRA_ARGS=.*/DROPBEAR_EXTRA_ARGS="-p 144 -p 8080"/g' /etc/default/dropbear
sed -i 's%DROPBEAR_BANNER=.*%DROPBEAR_BANNER="/etc/banner"%' /etc/default/dropbear
sleep 20
systemctl restart dropbear

if ! systemctl status dropbear &> /dev/null; then
   printf "\nFailed to install Dropbear\n" && err
fi

rm -f setup-dropbear.sh

#unistall
#sudo apt-get purge dropbear -y
