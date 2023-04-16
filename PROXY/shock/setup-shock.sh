sudo apt install dante-server
sudo nano /etc/danted.conf
netstat -plnt | grep -i danted
sudo systemctl restart danted
sudo systemctl enable danted
sudo service danted status
adduser --shell /usr/sbin/nologin --no-create-home proxyuser
sudo passwd proxyuser
curl https://ipinfo.io -x "socks5://master:qwerty@3.1.58.120:1080"
