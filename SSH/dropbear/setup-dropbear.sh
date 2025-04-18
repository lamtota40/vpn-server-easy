#!/bin/bash

apt install dropbear -y
cp /etc/default/dropbear /etc/default/dropbear.bak
sed -i "s/NO_START=.*/NO_START=0/" /etc/default/dropbear
sed -i "s/DROPBEAR_PORT=.*/DROPBEAR_PORT=23/" /etc/default/dropbear
sed -i 's/DROPBEAR_EXTRA_ARGS=.*/DROPBEAR_EXTRA_ARGS="-p 144 -p 7000"/g' /etc/default/dropbear
sed -i 's%DROPBEAR_BANNER=.*%DROPBEAR_BANNER="/etc/banner"%' /etc/default/dropbear
/etc/init.d/dropbear restart

rm -rf setup-dropbear.sh
