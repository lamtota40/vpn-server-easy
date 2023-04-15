#!/bin/bash

# detail ssl
CN=*.whatsapp.com
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

wget -O /etc/stunnel/stunnel.conf "https://raw.githubusercontent.com/lamtota40/vpn-server-easy/main/SSH/stunel4/stunnel.conf"

sed -i 's/ENABLED=0/ENABLED=1/g' /etc/default/stunnel4
/etc/init.d/stunnel4 restart

if ! systemctl status stunnel4 &> /dev/null; then
   printf "\nFailed to install Stunnel4\n" && err
fi

rm -rf setup-stunnel4.sh
