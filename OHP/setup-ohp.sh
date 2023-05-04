#!/bin/bash

wget -O ohpserver-linux32.zip https://raw.githubusercontent.com/lamtota40/vpn-server-easy/main/OHP/ohpserver-linux32.zip
unzip ohpserver-linux32.zip
chmod +x ohpserver
cp ohpserver /usr/local/bin/ohpserver
/bin/rm -rf ohpserver*

# Installing Service
# OpenSSH OHP Port 8080
cat > /etc/systemd/system/ssh-ohp.service << END
[Unit]
Description=OHP Server Default Server Service
Documentation=https://github.com/cybertize/
After=network.target network-online.target nss-lookup.target

[Service]
User=nobody
CapabilityBoundingSet=CAP_NET_ADMIN CAP_NET_BIND_SERVICE
AmbientCapabilities=CAP_NET_ADMIN CAP_NET_BIND_SERVICE
NoNewPrivileges=true
ExecStart=/usr/local/bin/ohpserver -port 8080 -proxy 127.0.0.1:3128 -tunnel 127.0.0.1:22
Restart=on-failure
RestartPreventExitStatus=23

[Install]
WantedBy=multi-user.target
END

# Dropbear OHP 8181
cat > /etc/systemd/system/dropbear-ohp.service << END
[Unit]
Description=OHP Server Default Server Service
Documentation=https://github.com/cybertize/
After=network.target network-online.target nss-lookup.target

[Service]
User=nobody
CapabilityBoundingSet=CAP_NET_ADMIN CAP_NET_BIND_SERVICE
AmbientCapabilities=CAP_NET_ADMIN CAP_NET_BIND_SERVICE
NoNewPrivileges=true
ExecStart=/usr/local/bin/ohpserver -port 8181 -proxy 127.0.0.1:3128 -tunnel 127.0.0.1:23
Restart=on-failure
RestartPreventExitStatus=23

[Install]
WantedBy=multi-user.target
END

# OpenVPN OHP 8282
cat > /etc/systemd/system/openvpn-ohp.service << END
[Unit]
Description=OHP Server Default Server Service
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
systemctl enable ssh-ohp
systemctl restart ssh-ohp
systemctl enable dropbear-ohp
systemctl restart dropbear-ohp
systemctl enable openvpn-ohp
systemctl restart openvpn-ohp

rm -rf setup-ohp.sh
