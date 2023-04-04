#!/bin/bash

# detail nama perusahaan
country=ID
state=Bandung
locality=Jawa Barat
organization=VPN Crops
organizationalunit=myVPN
CN=vpncrops.com
email=admin@vpncrops.com

echo "=================  membuat Sertifikat OpenSSL ======================"
echo "========================================================="
#membuat sertifikat
openssl genrsa -out key.pem 2048
openssl req -new -x509 -key key.pem -out cert.pem -days 1095 \
-subj "/C=$country/ST=$state/L=$locality/O=$organization/OU=$organizationalunit/CN=$CN/emailAddress=$email"
cat key.pem cert.pem >> /etc/stunnel/stunnel.pem

#rm -rf stunnel.sh
