
apt instal make git -y
git@github.com:yrutschle/sslh.git
make
cp sslh-fork /usr/local/sbin/sslh
cp basic.cfg /etc/sslh.cfg
vi /etc/sslh.cfg
