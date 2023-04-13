# Edit file /etc/systemd/system/rc-local.service
cat > /etc/systemd/system/rc-local.service <<-END
[Unit]
Description=/etc/rc.local
ConditionPathExists=/etc/rc.local
[Service]
Type=forking
ExecStart=/etc/rc.local start
TimeoutSec=0
StandardOutput=tty
RemainAfterExit=yes
SysVStartPriority=99
[Install]
WantedBy=multi-user.target
END

# nano /etc/rc.local
cat > /etc/rc.local <<-END
#!/bin/sh -e
# rc.local
# By default this script does nothing.
exit 0
END

# Ubah izin akses
chmod +x /etc/rc.local

# enable rc local
systemctl enable rc-local
systemctl start rc-local.service

# install wget and curl
#apt -y install wget curl
apt -y install python

# install python
cd
gem install lolcat
apt -y install figlet

# install
apt-get -y bzip2 gzip wget screen htop net-tools zip unzip wget curl nano sed screen

# Install Requirements Tools
apt install python -y
apt install make -y
apt install cmake -y
apt install jq -y
apt install apt-transport-https -y
#apt install neofetch -y
apt install git -y
apt install gcc -y
apt install g++ -y

apt install dropbear -y
cp /etc/default/dropbear /etc/default/dropbear.bak
sed -i "s/NO_START=.*/NO_START=0/" /etc/default/dropbear
sed -i "s/DROPBEAR_PORT=.*/DROPBEAR_PORT=88/" /etc/default/dropbear
sed -i 's/DROPBEAR_EXTRA_ARGS=.*/DROPBEAR_EXTRA_ARGS="-p 23 -p 144 -p 7000 -p 88 -p 69"/g' /etc/default/dropbear
sed -i 's%DROPBEAR_BANNER=.*%DROPBEAR_BANNER="/etc/banner"%' /etc/default/dropbear
systemctl restart dropbear

#tambahan package nettools
#apt-get install net-tools 

#instalasi Websocket
#wget https://raw.githubusercontent.com/hidessh99/projectku/main/websocket/hideinstall-websocket.sh && chmod +x hideinstall-websocket.sh && ./hideinstall-websocket.sh

# Websocket HTTP
#accept http port 80 to port 88 
cd
wget -O /usr/local/bin/edu-proxy https://raw.githubusercontent.com/lamtota40/vpn-server-easy/main/coba/ws-http.py && chmod +x /usr/local/bin/edu-proxy
wget -O /etc/systemd/system/edu-proxy.service https://gitlab.com/hidessh/baru/-/raw/main/websocket-python/baru/http.service && chmod +x /etc/systemd/system/edu-proxy.service

systemctl daemon-reload
systemctl enable edu-proxy.service
systemctl start edu-proxy.service
systemctl restart edu-proxy.service
