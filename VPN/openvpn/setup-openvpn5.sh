#!/bin/bash

# initialisasi var
export DEBIAN_FRONTEND=noninteractive
OS=`uname -m`;
MYIP=$(wget -4qO- ipinfo.io/ip);
MYIP2="s/xxxxxxxxx/$MYIP/g";

# Install OpenVPN dan Easy-RSA
apt install netfilter-persistent openvpn easy-rsa unzip -y
apt install openssl iptables iptables-persistent -y
mkdir -p /etc/openvpn/server/easy-rsa/
cd /etc/openvpn/
wget -O vpn.zip https://github.com/lamtota40/vpn-server-easy/raw/main/VPN/openvpn/vpn.zip
unzip vpn.zip
rm -f vpn.zip
chown -R root:root /etc/openvpn/server/easy-rsa/

cd
# Membuat direktori kerja untuk Easy-RSA
EASYRSA_DIR=~/easy-rsa
mkdir -p $EASYRSA_DIR
cp -r /usr/share/easy-rsa/* $EASYRSA_DIR

# Masuk ke direktori Easy-RSA
cd $EASYRSA_DIR

# Inisialisasi PKI
./easyrsa init-pki

# Mengedit file vars
cat <<EOL > vars
set_var EASYRSA_REQ_COUNTRY    "ID"
set_var EASYRSA_REQ_PROVINCE   "DKI Jakarta"
set_var EASYRSA_REQ_CITY       "Jakarta"
set_var EASYRSA_REQ_ORG        "NamaOrganisasi"
set_var EASYRSA_REQ_EMAIL      "email@mydomain.com"
set_var EASYRSA_REQ_OU         "UnitOrganisasi"
EOL

CN="toxa.ix.tc"
# Membuat CA
echo "$CN" | ./easyrsa build-ca nopass
cp /root/easy-rsa/pki/ca.crt /etc/openvpn/

# Membuat sertifikat server
(echo "$CN"; echo "yes") | ./easyrsa gen-req server nopass
cp /root/easy-rsa/pki/reqs/server.req /etc/openvpn/
cp /root/easy-rsa/pki/private/server.key /etc/openvpn/

echo "yes" | ./easyrsa sign-req server server
cp /root/easy-rsa/pki/issued/server.crt /etc/openvpn/

# Membuat Diffie-Hellman
./easyrsa gen-dh
cp /root/easy-rsa/pki/dh.pem /etc/openvpn/

cd
mkdir -p /usr/lib/openvpn/
cp /usr/lib/x86_64-linux-gnu/openvpn/plugins/openvpn-plugin-auth-pam.so /usr/lib/openvpn/openvpn-plugin-auth-pam.so

# nano /etc/default/openvpn
sed -i 's/#AUTOSTART="all"/AUTOSTART="all"/g' /etc/default/openvpn

# restart openvpn dan cek status openvpn
systemctl enable --now openvpn-server@server-tcp-1194
systemctl enable --now openvpn-server@server-udp-2200
/etc/init.d/openvpn restart
/etc/init.d/openvpn status

# aktifkan ip4 forwarding
echo 1 > /proc/sys/net/ipv4/ip_forward
sed -i 's/#net.ipv4.ip_forward=1/net.ipv4.ip_forward=1/g' /etc/sysctl.conf

# Buat config client TCP 1194
cat > /etc/openvpn/client-tcp-1194.ovpn <<-END
client
dev tun
proto tcp
remote xxxxxxxxx 1194
resolv-retry infinite
route-method exe
nobind
persist-key
persist-tun
auth-user-pass
comp-lzo
verb 3
END

sed -i $MYIP2 /etc/openvpn/client-tcp-1194.ovpn;

# Buat config client UDP 2200
cat > /etc/openvpn/client-udp-2200.ovpn <<-END
client
dev tun
proto udp
remote xxxxxxxxx 2200
resolv-retry infinite
route-method exe
nobind
persist-key
persist-tun
auth-user-pass
comp-lzo
verb 3
END

sed -i $MYIP2 /etc/openvpn/client-udp-2200.ovpn;

# Buat config client SSL
cat > /etc/openvpn/client-tcp-ssl.ovpn <<-END
client
dev tun
proto tcp
remote xxxxxxxxx 995
resolv-retry infinite
route-method exe
nobind
persist-key
persist-tun
auth-user-pass
comp-lzo
verb 3
END

sed -i $MYIP2 /etc/openvpn/client-tcp-ssl.ovpn;

cd
# pada tulisan xxx ganti dengan alamat ip address VPS anda 
/etc/init.d/openvpn restart

# masukkan certificatenya ke dalam config client TCP 1194
echo '<ca>' >> /etc/openvpn/client-tcp-1194.ovpn
cat /etc/openvpn/server/ca.crt >> /etc/openvpn/client-tcp-1194.ovpn
echo '</ca>' >> /etc/openvpn/client-tcp-1194.ovpn

# masukkan certificatenya ke dalam config client UDP 2200
echo '<ca>' >> /etc/openvpn/client-udp-2200.ovpn
cat /etc/openvpn/server/ca.crt >> /etc/openvpn/client-udp-2200.ovpn
echo '</ca>' >> /etc/openvpn/client-udp-2200.ovpn

# masukkan certificatenya ke dalam config client SSL
echo '<ca>' >> /etc/openvpn/client-tcp-ssl.ovpn
cat /etc/openvpn/server/ca.crt >> /etc/openvpn/client-tcp-ssl.ovpn
echo '</ca>' >> /etc/openvpn/client-tcp-ssl.ovpn

# Copy config OpenVPN to web
cp /etc/openvpn/client-tcp-1194.ovpn /var/www/html/tcp-1194.ovpn
cp /etc/openvpn/client-tcp-ssl.ovpn /var/www/html/tcpssl-995.ovpn
cp /etc/openvpn/client-udp-2200.ovpn /var/www/html/udp-2200.ovpn

#firewall untuk memperbolehkan akses UDP dan akses jalur TCP
#ANU=$(ip -o $ANU -4 route show to default | awk '{print $5}');
#iptables -t nat -I POSTROUTING -s 10.6.0.0/24 -o $ANU -j MASQUERADE
#iptables -t nat -I POSTROUTING -s 10.7.0.0/24 -o $ANU -j MASQUERADE
#iptables-save > /etc/iptables.up.rules
#chmod +x /etc/iptables.up.rules

#iptables-restore -t < /etc/iptables.up.rules
#netfilter-persistent save
#netfilter-persistent reload

# Restart service openvpn
systemctl enable openvpn
systemctl start openvpn
/etc/init.d/openvpn restart

#zip file openvpn
cd /var/www/html/
zip -r openvpn-confall.zip tcp-1194.ovpn tcpssl-995.ovpn udp-2200.ovpn
cd

rm -rf setup-openvpn5.sh
