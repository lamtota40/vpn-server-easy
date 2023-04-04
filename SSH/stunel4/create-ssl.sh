#!/bin/bash

# detail nama perusahaan
CN=*.game.naver.com
organization=NAVER
country=ID
state=Bandung
locality=Jawa Barat
organizationalunit=myVPN
email=admin@vpncrops.com

echo "=================  membuat Sertifikat OpenSSL ======================"
echo "========================================================="
#membuat sertifikat
openssl genrsa -out key.pem 2048
#openssl req -new -x509 -key key.pem -out cert.pem -days 1095 \
-subj "/C=$country/ST=$state/L=$locality/O=$organization/OU=$organizationalunit/CN=$CN/emailAddress=$email"

openssl req -new -x509 -key key.pem -out cert.pem -days 1095 \
-subj "/CN=$CN"
cat key.pem cert.pem >> /etc/stunnel/stunnel.pem

#rm -rf stunnel.sh
