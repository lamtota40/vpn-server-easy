#!/bin/bash

if [ ! $(which sshd) ]; then
   apt install openssh-server -y
fi

echo "Progress Setting SSH"
cp /etc/ssh/sshd_config /etc/ssh/sshd_config.bak
sed -i 's/#Port 22/Port 22/g' /etc/ssh/sshd_config
echo "Port 143" >> /etc/ssh/sshd_config
echo "Port 8000" >> /etc/ssh/sshd_config
sed -i 's%#Banner.*%Banner /etc/banner%' /etc/ssh/sshd_config
sed -i 's/PasswordAuthentication .*/PasswordAuthentication yes/g' /etc/ssh/sshd_config
sed -i 's/#PubkeyAuthentication .*/PubkeyAuthentication no/g' /etc/ssh/sshd_config
sed -i 's/#PermitEmptyPasswords .*/PermitEmptyPasswords no/g' /etc/ssh/sshd_config
sed -i 's/#PermitRootLogin .*/PermitRootLogin yes/g' /etc/ssh/sshd_config

#echo "Port 2222" >> /etc/ssh/sshd_config
#echo "Port 2269" >> /etc/ssh/sshd_config
#sed -i 's/#AllowTcpForwarding yes/AllowTcpForwarding yes/g' /etc/ssh/sshd_config
service sshd restart
#apt-get purge openssh-server -y

rm -rf setup-openssh.sh
