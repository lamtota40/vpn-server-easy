
apt instal make libconfig-dev libwrap0-dev libsystemd-dev libcap-dev libbsd-dev libev-dev libpcre2-dev git -y
git clone https://github.com/yrutschle/sslh.git
cd sslh
make
cp sslh-fork /usr/local/sbin/sslh
cp basic.cfg /etc/sslh.cfg
vi /etc/sslh.cfg
