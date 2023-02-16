#!/bin/bash

apt install dropbear -y
systemctl stop dropbear
sudo cp /etc/default/dropbear /etc/default/dropbear.bak

default_port= "443"
extra_port= "-p 80 -p 8080"

sed -i -e 's/NO_START=1/NO_START=0/g' /etc/default/dropbear
sed -i -e 's/DROPBEAR_PORT=22/DROPBEAR_PORT=$default_port/g' /etc/default/dropbear
sed -i -e 's/DROPBEAR_EXTRA_ARGS=/DROPBEAR_EXTRA_ARGS=$extra_port/g' /etc/default/dropbear
systemctl enable dropbear
systemctl start dropbear

#unistall
#sudo apt-get purge dropbear -y

sed -i -e 's/DROPBEAR_EXTRA_ARGS=/DROPBEAR_EXTRA_ARGS=-p 80 -p 8080/g' /etc/default/dropbear
