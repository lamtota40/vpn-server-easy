#!/bin/bash

#install dependcy
apt install python3 python3-dnslib net-tools -y
apt install dnsutils gnutls-bin dos2unix debconf-utils -y
apt install cron iptables netfilter-persistent -y

#iptables -I INPUT -p udp --dport 5300 -j ACCEPT
#iptables -t nat -I PREROUTING -p udp --dport 53 -j REDIRECT --to-ports 5300
#netfilter-persistent save
#netfilter-persistent reload

cd
#mkdir /root/myvpn
#echo "ns.sit.my.id" > /root/myvpn/nsdomain

nameserver=$(cat /root/myvpn/nsdomain)

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
ExecStart=/etc/slowdns/sldns-server -udp :5300 -privkey-file /etc/slowdns/server.key $nameserver 127.0.0.1:80
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

systemctl restart client-sldns
systemctl restart server-sldns

#Auto start slowdns if error
wget -O /root/myvpn/cron/slowdns-eror https://raw.githubusercontent.com/lamtota40/vpn-server-easy/main/slowdns/slowdns-error
chmod +x /root/myvpn/cron/slowdns-eror
echo "0 4 * * * root /root/myvpn/cron/slowdns-eror" >> /etc/cron.d/autoreboot
echo "0 18 * * * root /root/myvpn/cron/slowdns-eror" >> /etc/cron.d/autoreboot
service cron reload
service cron restart

#sed -i 's/#Port 22/Port 22/g' /etc/ssh/sshd_config
#echo "Port 2222" >> /etc/ssh/sshd_config
#sed -i 's/#AllowTcpForwarding yes/AllowTcpForwarding yes/g' /etc/ssh/sshd_config
#service sshd restart

rm -rf setup-slowdns.sh
