#!/bin/bash

# detail ssl
CN=$(cat /root/myvpn/domain)
#CN=*.myweb.com
#organization=NAVER
#country=ID
#state=Bandung
#locality=Jawa Barat
#organizationalunit=myVPN
#email=admin@vpncrops.com

apt install stunnel4 -y

rm -rf /etc/stunnel/stunnel.pem

#create key.pem
openssl genrsa -out key.pem 2048
#create cert.pem
#openssl req -new -x509 -key key.pem -out cert.pem -days 1095 -subj "/C=$country/ST=$state/L=$locality/O=$organization/OU=$organizationalunit/CN=$CN/emailAddress=$email"
openssl req -new -x509 -key key.pem -out cert.pem -days 1095 -subj "/CN=$CN"

cat key.pem cert.pem >> /etc/stunnel/stunnel.pem

wget -O /etc/stunnel/stunnel.conf "https://raw.githubusercontent.com/lamtota40/vpn-server-easy/main/stunnel4/stunnel.conf"
chmod 600 /etc/stunnel/stunnel.pem

sed -i 's/ENABLED=0/ENABLED=1/g' /etc/default/stunnel4
/etc/init.d/stunnel4 restart

cp key.pem /root/myvpn/config/key.pem
cp cert.pem /root/myvpn/config/cert.pem
rm -rf key.pem
rm -rf cert.pem

rm -rf setup-stunnel4.sh
