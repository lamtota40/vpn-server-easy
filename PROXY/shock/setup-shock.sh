sudo apt install dante-server
sudo nano /etc/danted.conf
netstat -plnt | grep -i danted
sudo systemctl restart danted
sudo systemctl enable danted
sudo service danted status
adduser --shell /usr/sbin/nologin --no-create-home proxyuser
sudo passwd proxyuser
curl http://portquiz.net --proxy "socks5://xxx.xxx.xxx.xxx:1080"
curl http://portquiz.net --proxy "socks5://user:pass@xxx.xxx.xxx.xxx:1080"
