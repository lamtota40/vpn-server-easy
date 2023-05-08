#!/bin/bash

Login="master"
Pass="qwerty"
useradd -m -s /bin/bash $Login
echo -e "$Pass\n$Pass\n" | passwd $Login &> /dev/null
usermod -aG sudo $Login

cd
wget -O /etc/banner https://raw.githubusercontent.com/lamtota40/vpn-server-easy/main/tools/other/banner
cp /etc/ssh/sshd_config /etc/ssh/sshd_config.bak
sed -i 's/#Port 22/Port 22/g' /etc/ssh/sshd_config
echo "Port 2222" >> /etc/ssh/sshd_config
echo "Port 2223" >> /etc/ssh/sshd_config
sed -i 's%#Banner.*%Banner /etc/banner%' /etc/ssh/sshd_config
sed -i 's/PasswordAuthentication .*/PasswordAuthentication yes/g' /etc/ssh/sshd_config
sed -i 's/#PubkeyAuthentication .*/PubkeyAuthentication yes/g' /etc/ssh/sshd_config
sed -i 's/#AllowTcpForwarding yes/AllowTcpForwarding yes/g' /etc/ssh/sshd_config
#sed -i 's/AcceptEnv/#AcceptEnv/g' /etc/ssh/sshd_config
systemctl restart ssh

#setting IPtables
apt install iptables netfilter-persistent -y
iptables -I INPUT -p udp --dport 5300 -j ACCEPT
iptables -t nat -I PREROUTING -p udp --dport 53 -j REDIRECT --to-ports 5300
#iptables-save > /etc/iptables.up.rules
#iptables-restore -t < /etc/iptables.up.rules
netfilter-persistent save
netfilter-persistent reload

cd
#input nameserver manual to cloudflare

#read -rp "input your domain: " -e domain
#NS_DOMAIN=slow.${domain}
echo "slow-id.vip.sit.my.id" > /root/nsdomain

nameserver=$(cat /root/nsdomain)
apt install -y python3 python3-dnslib net-tools
apt install ncurses-utils -y
apt install dnsutils -y
apt install gnutls-bin -y
apt install dos2unix debconf-utils -y

#configuration slowdns
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
#for service startup-client slowdns
cat > /etc/systemd/system/client-sldns.service << END
[Unit]
Description=Client SlowDNS
Documentation=https://github.com/lamtota40
After=network.target nss-lookup.target

[Service]
Type=simple
User=root
CapabilityBoundingSet=CAP_NET_ADMIN CAP_NET_BIND_SERVICE
AmbientCapabilities=CAP_NET_ADMIN CAP_NET_BIND_SERVICE
NoNewPrivileges=true
ExecStart=/etc/slowdns/sldns-client -udp 174.138.21.128:53 --pubkey-file /etc/slowdns/server.pub $nameserver 127.0.0.1:88
Restart=on-failure

[Install]
WantedBy=multi-user.target
END

cd
#for service startup-server slowdns
cat > /etc/systemd/system/server-sldns.service << END
[Unit]
Description=Server SlowDNS
Documentation=https://github.com/lamtota40
After=network.target nss-lookup.target

[Service]
Type=simple
User=root
CapabilityBoundingSet=CAP_NET_ADMIN CAP_NET_BIND_SERVICE
AmbientCapabilities=CAP_NET_ADMIN CAP_NET_BIND_SERVICE
NoNewPrivileges=true
ExecStart=/etc/slowdns/sldns-server -udp :5300 -privkey-file /etc/slowdns/server.key $nameserver 127.0.0.1:443
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

systemctl daemon-reload
systemctl stop client-sldns
systemctl stop server-sldns

systemctl enable client-sldns
systemctl enable server-sldns

systemctl start client-sldns
systemctl start server-sldns

#systemctl restart client-sldns
#systemctl restart server-sldns

#rm -rf setup-slowdns.sh
