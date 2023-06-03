tes
apt install haproxy -y
sudo cp -a /etc/haproxy/haproxy.cfg{,.bak}
systemctl restart haproxy
