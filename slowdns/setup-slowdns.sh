#!/bin/bash

Login="master"
Pass="qwerty"
useradd -m -s /bin/bash $Login
echo -e "$Pass\n$Pass\n" | passwd $Login &> /dev/null
usermod -aG sudo $Login

#setting IPtables
apt install iptables netfilter-persistent -y

iptables -I INPUT -p udp --dport 5300 -j ACCEPT
iptables -t nat -I PREROUTING -p udp --dport 53 -j REDIRECT --to-ports 5300
netfilter-persistent save
netfilter-persistent reload

cd
mkdir /root/myvpn
echo "slow-id.vip.sit.my.id" > /root/myvpn/nsdomain

nameserver=$(cat /root/myvpn/nsdomain)
apt install -y python3 python3-dnslib net-tools
apt install dnsutils gnutls-bin dos2unix debconf-utils -y
apt install cron -y
service cron reload
service cron restart

#tambahan port openssh
cd
echo "Port 2222" >> /etc/ssh/sshd_config
echo "Port 2269" >> /etc/ssh/sshd_config
sed -i 's/#AllowTcpForwarding yes/AllowTcpForwarding yes/g' /etc/ssh/sshd_config
service sshd restart

#konfigurasi slowdns
rm -rf /etc/slowdns
mkdir -m 777 /etc/slowdns
wget -q -O /etc/slowdns/server.key "https://raw.githubusercontent.com/lamtota40/vpn-server-easy/main/slowdns/server.key"
wget -q -O /etc/slowdns/server.pub "https://raw.githubusercontent.com/lamtota40/vpn-server-easy/main/slowdns/server.pub"
wget -q -O /etc/slowdns/sldns-server "https://raw.githubusercontent.com/lamtota40/vpn-server-easy/main/slowdns/sldns-server"
wget -q -O /etc/slowdns/sldns-client "https://raw.githubusercontent.com/lamtota40/vpn-server-easy/main/slowdns/sldns-client"
cd
chmod +x /etc/slowdns/server.key
chmod +x /etc/slowdns/server.pub
chmod +x /etc/slowdns/sldns-server
chmod +x /etc/slowdns/sldns-client

cd
#install client-sldns.service
cat > /etc/systemd/system/client-sldns.service << END
[Unit]
Description=Client SlowDNS By HideSSH
Documentation=https://hidessh.com
After=network.target nss-lookup.target

[Service]
Type=simple
User=root
CapabilityBoundingSet=CAP_NET_ADMIN CAP_NET_BIND_SERVICE
AmbientCapabilities=CAP_NET_ADMIN CAP_NET_BIND_SERVICE
NoNewPrivileges=true
ExecStart=/etc/slowdns/sldns-client -udp 8.8.8.8:53 --pubkey-file /etc/slowdns/server.pub $nameserver 127.0.0.1:2222
Restart=on-failure

[Install]
WantedBy=multi-user.target
END

cd
#install server-sldns.service
cat > /etc/systemd/system/server-sldns.service << END
[Unit]
Description=Server SlowDNS By HideSSH
Documentation=https://hidessh.com
After=network.target nss-lookup.target

[Service]
Type=simple
User=root
CapabilityBoundingSet=CAP_NET_ADMIN CAP_NET_BIND_SERVICE
AmbientCapabilities=CAP_NET_ADMIN CAP_NET_BIND_SERVICE
NoNewPrivileges=true
ExecStart=/etc/slowdns/sldns-server -udp :5300 -privkey-file /etc/slowdns/server.key $nameserver 127.0.0.1:2269
Restart=on-failure

[Install]
WantedBy=multi-user.target
END

#permission service slowdns
cd
chmod +x /etc/systemd/system/client-sldns.service
chmod +x /etc/systemd/system/server-sldns.service
pkill sldns-server
pkill sldns-client

#enable service slowdns
systemctl daemon-reload
systemctl stop client-sldns
systemctl stop server-sldns

systemctl enable client-sldns
systemctl enable server-sldns

systemctl start client-sldns
systemctl start server-sldns

#systemctl restart client-sldns
#systemctl restart server-sldns

# download script
wget -O /usr/bin/slowdns-eror "https://raw.githubusercontent.com/lamtota40/vpn-server-easy/main/slowdns/slowdns-error"
chmod +x /usr/bin/slowdns-eror

echo "0 4 * * * root slowdns-eror" >> /etc/crontab
echo "0 18 * * * root slowdns-eror" >> /etc/crontab
