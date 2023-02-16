
apt-get install dropbear -y
sudo cp /etc/default/dropbear /etc/default/dropbear.bak
nano /etc/default/dropbear

NO_START=0
DROPBEAR_EXTRA_ARGS="-p 109 -p 443 -p 143"

#sudo apt-get purge dropbear -y
