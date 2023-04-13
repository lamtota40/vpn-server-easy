
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

# disable ipv6
#echo 1 > /proc/sys/net/ipv6/conf/all/disable_ipv6
#sed -i '$ i\echo 1 > /proc/sys/net/ipv6/conf/all/disable_ipv6' /etc/rc.local

#update
#apt-get remove --purge ufw firewalld -y
#apt-get remove --purge exim4 -y

# install wget and curl
#apt -y install wget curl
apt -y install python

# install python
cd
gem install lolcat
apt -y install figlet

# set time GMT +7
#ln -fs /usr/share/zoneinfo/Asia/Jakarta /etc/localtime


# install
apt-get -y bzip2 gzip wget screen htop net-tools zip unzip wget curl nano sed screen

# Install Requirements Tools
apt install python -y
apt install make -y
apt install cmake -y
apt install jq -y
apt install apt-transport-https -y
apt install neofetch -y
apt install git -y
apt install gcc -y
apt install g++ -y

#tambahan package nettools
apt-get install net-tools -y

#hapus apache
#apt-get remove apache2 -y
#apt-get purge apache2* -y

# install webserver
#apt -y install nginx
#cd
#rm /etc/nginx/sites-enabled/default
#rm /etc/nginx/sites-available/default
#wget -O /etc/nginx/nginx.conf "https://gitlab.com/hidessh/baru/-/raw/main/nginx.conf"
#mkdir -p /home/vps/public_html
#wget -O /etc/nginx/conf.d/vps.conf "https://gitlab.com/hidessh/baru/-/raw/main/vps.conf"
#/etc/init.d/nginx restart

# install badvpn
#cd
#wget -O /usr/bin/badvpn-udpgw "https://gitlab.com/hidessh/baru/-/raw/main/badvpn-udpgw64"
#chmod +x /usr/bin/badvpn-udpgw

#installer badvpn
#wget https://raw.githubusercontent.com/hidessh99/projectku/main/badvpn/installer-badvpn.sh && chmod +x installer-badvpn.sh && ./installer-badvpn.sh


# setting port ssh
sed -i '/Port 22/a Port 88' /etc/ssh/sshd_config
sed -i 's/#Port 22/Port 22/g' /etc/ssh/sshd_config
sed -i 's/AcceptEnv/#AcceptEnv/g' /etc/ssh/sshd_config
service ssh restart
/etc/init.d/ssh restart


# install dropbear
apt -y install dropbear
sed -i 's/NO_START=1/NO_START=0/g' /etc/default/dropbear
sed -i 's/DROPBEAR_PORT=22/DROPBEAR_PORT=44/g' /etc/default/dropbear
sed -i 's/DROPBEAR_EXTRA_ARGS=/DROPBEAR_EXTRA_ARGS="-p 69 -p 77 -p 300"/g' /etc/default/dropbear
echo "/bin/false" >> /etc/shells
echo "/usr/sbin/nologin" >> /etc/shells
/etc/init.d/dropbear restart


#instalasi Websocket
wget https://raw.githubusercontent.com/hidessh99/projectku/main/websocket/hideinstall-websocket.sh && chmod +x hideinstall-websocket.sh && ./hideinstall-websocket.sh


