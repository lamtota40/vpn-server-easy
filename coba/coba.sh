
# Install Requirements Tools
apt install python -y

# install dropbear
apt -y install dropbear
sed -i 's/NO_START=1/NO_START=0/g' /etc/default/dropbear
sed -i 's/DROPBEAR_PORT=22/DROPBEAR_PORT=44/g' /etc/default/dropbear
sed -i 's/DROPBEAR_EXTRA_ARGS=/DROPBEAR_EXTRA_ARGS="-p 69 -p 77 -p 300"/g' /etc/default/dropbear
echo "/bin/false" >> /etc/shells
echo "/usr/sbin/nologin" >> /etc/shells
/etc/init.d/dropbear restart

#instalasi Websocket
#accept http port 44 to port 88
wget -O /usr/local/bin/edu-proxy https://raw.githubusercontent.com/lamtota40/vpn-server-easy/main/coba/ws-http.py && chmod +x /usr/local/bin/edu-proxy
wget -O /etc/systemd/system/edu-proxy.service https://gitlab.com/hidessh/baru/-/raw/main/websocket-python/baru/http.service && chmod +x /etc/systemd/system/edu-proxy.service

systemctl daemon-reload
systemctl enable edu-proxy.service
systemctl start edu-proxy.service
systemctl restart edu-proxy.service
