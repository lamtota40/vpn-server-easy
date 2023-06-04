#!/bin/bash

wget -O ohpserver-linux32.zip https://raw.githubusercontent.com/lamtota40/vpn-server-easy/main/OHP/ohpserver-linux32.zip
unzip ohpserver-linux32.zip
chmod +x ohpserver
cp ohpserver /usr/local/bin/ohpserver
/bin/rm -rf ohpserver*

# OHP Server Dropbear 8080
cat > /etc/systemd/system/ohp-dropbear.service << END
[Unit]
Description=OHP Server Dropbear 8080
Documentation=https://github.com/cybertize/
After=network.target network-online.target nss-lookup.target

[Service]
User=nobody
CapabilityBoundingSet=CAP_NET_ADMIN CAP_NET_BIND_SERVICE
AmbientCapabilities=CAP_NET_ADMIN CAP_NET_BIND_SERVICE
NoNewPrivileges=true
ExecStart=/usr/local/bin/ohpserver -port 8080 -proxy 127.0.0.1:3128 -tunnel 127.0.0.1:23
Restart=on-failure
RestartPreventExitStatus=23

[Install]
WantedBy=multi-user.target
END

# OHP Server OpenSSH 8181
cat > /etc/systemd/system/ohp-dropbear.service << END
[Unit]
Description=OHP Server OpenSSH 8181
Documentation=https://github.com/cybertize/
After=network.target network-online.target nss-lookup.target

[Service]
User=nobody
CapabilityBoundingSet=CAP_NET_ADMIN CAP_NET_BIND_SERVICE
AmbientCapabilities=CAP_NET_ADMIN CAP_NET_BIND_SERVICE
NoNewPrivileges=true
ExecStart=/usr/local/bin/ohpserver -port 8181 -proxy 127.0.0.1:3128 -tunnel 127.0.0.1:22
Restart=on-failure
RestartPreventExitStatus=23

[Install]
WantedBy=multi-user.target
END

# OHP Server OpenVPN 8282
cat > /etc/systemd/system/ohp-openvpn.service << END
[Unit]
Description=OHP Server OpenVPN 8282
Documentation=https://github.com/cybertize/
After=network.target network-online.target nss-lookup.target

[Service]
User=nobody
CapabilityBoundingSet=CAP_NET_ADMIN CAP_NET_BIND_SERVICE
AmbientCapabilities=CAP_NET_ADMIN CAP_NET_BIND_SERVICE
NoNewPrivileges=true
ExecStart=/usr/local/bin/ohpserver -port 8282 -proxy 127.0.0.1:3128 -tunnel 127.0.0.1:1194
Restart=on-failure
RestartPreventExitStatus=23

[Install]
WantedBy=multi-user.target
END

systemctl daemon-reload
systemctl enable ohp-ssh
systemctl start ohp-ssh
systemctl restart ohp-ssh

systemctl enable ohp-dropbear
systemctl start ohp-dropbear
systemctl restart ohp-dropbear

systemctl enable ohp-openvpn
systemctl start ohp-openvpn
systemctl restart ohp-openvpn

rm -rf setup-ohp.sh
