
apt instal make git -y
git clone https://github.com/yrutschle/sslh.git
cd sslh
make
cp sslh-fork /usr/local/sbin/sslh
cp basic.cfg /etc/sslh.cfg
vi /etc/sslh.cfg
