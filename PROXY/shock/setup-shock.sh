sudo apt install dante-server
sudo nano /etc/danted.conf
netstat -plnt | grep -i danted
sudo service danted restart
sudo service danted status
adduser --shell /usr/sbin/nologin --no-create-home danted-user
curl -x "socks5://username:password@ip-server:port" -skL "https://ipinfo.io"
