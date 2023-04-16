sudo apt install dante-server
sudo nano /etc/danted.conf
netstat -plnt | grep -i danted
sudo systemctl restart danted
sudo systemctl enable danted
sudo service danted status
adduser --shell /usr/sbin/nologin --no-create-home proxyuser
sudo passwd proxyuser
curl -x "socks5://username:password@ip-server:port" -skL "https://ipinfo.io"

curl -x "socks5://3.1.58.120:1080" -skL "https://ipinfo.io"
