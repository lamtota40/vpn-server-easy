# Instalasi OpenVPN dan Easy-RSA
apt-get update
apt-get install -y openvpn easy-rsa

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
set_var EASYRSA_REQ_PROVINCE   "Jawa"
set_var EASYRSA_REQ_CITY       "Jakarta"
set_var EASYRSA_REQ_ORG        "NamaOrganisasi"
set_var EASYRSA_REQ_EMAIL      "email@domain.com"
set_var EASYRSA_REQ_OU         "UnitOrganisasi"
EOL

CN="toxa.ix.tc"
# Membuat CA
echo "$CN" | ./easyrsa build-ca nopass

# Membuat sertifikat server
(echo "$CN"; echo "yes") | ./easyrsa gen-req server nopass
echo "yes" | ./easyrsa sign-req server server

# Membuat Diffie-Hellman
./easyrsa gen-dh

# Menyalin file ke direktori OpenVPN
cp pki/ca.crt pki/issued/server.crt pki/private/server.key pki/dh.pem /etc/openvpn/

# Membuat file konfigurasi server OpenVPN
cat <<EOL > /etc/openvpn/server.conf
port 1194
proto udp
dev tun
ca ca.crt
cert server.crt
key server.key
dh dh.pem
server 10.8.0.0 255.255.255.0
ifconfig-pool-persist ipp.txt
keepalive 10 120
cipher AES-256-CBC
user nobody
group nogroup
persist-key
persist-tun
status openvpn-status.log
verb 3
EOL

# Mengaktifkan dan memulai layanan OpenVPN
systemctl start openvpn@server
systemctl enable openvpn@server

# Membuat sertifikat klien
echo "$CN" | ./easyrsa gen-req client nopass
echo "yes" | ./easyrsa sign-req client client

# Menyalin file ke direktori klien
CLIENT_DIR=~/client-configs
mkdir -p $CLIENT_DIR
cp pki/ca.crt pki/issued/client.crt pki/private/client.key $CLIENT_DIR/

# Membuat file konfigurasi klien
cat <<EOL > $CLIENT_DIR/client.ovpn
client
dev tun
proto udp
remote your_server_ip 1194
resolv-retry infinite
nobind
user nobody
group nogroup
persist-key
persist-tun
ca ca.crt
cert client.crt
key client.key
cipher AES-256-CBC
verb 3
redirect-gateway def1
tls-version-min 1.2
tls-version-max 1.2
EOL

# Mengganti your_server_ip dengan alamat IP server
sed -i "s/your_server_ip/$(hostname -I | awk '{print $1}')/g" $CLIENT_DIR/client.ovpn

echo "OpenVPN dan Easy-RSA telah diinstal dan dikonfigurasi."
echo "File konfigurasi klien dapat ditemukan di: $CLIENT_DIR/client.ovpn"

cd
