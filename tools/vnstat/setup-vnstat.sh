#!/bin/bash

# setting vnstat
apt install vnstat make gcc -y
/etc/init.d/vnstat restart
apt -y install libsqlite3-dev
wget -O vnstat-2.10.tar.gz https://github.com/lamtota40/vpn-server-easy/raw/main/tools/vnstat/vnstat-2.10.tar.gz
tar zxvf vnstat-2.10.tar.gz
cd vnstat-2.10
./configure --prefix=/usr --sysconfdir=/etc && make && make install
cd
vnstat -u -i $NET
sed -i 's/Interface "'""eth0""'"/Interface "'""$NET""'"/g' /etc/vnstat.conf
chown vnstat:vnstat /var/lib/vnstat -R
systemctl enable vnstat
etc/init.d/vnstat restart

rm -f vnstat-2.10.tar.gz
rm -rf vnstat-2.10

rm -rf setup-vnstat.sh
