#!/bin/bash

apt-get install sslh -y
#konfigurasi
#port 333 to 44 and 777
wget -O /etc/default/sslh "https://gitlab.com/hidessh/baru/-/raw/main/SSLH/sslh.conf"
service sslh restart
