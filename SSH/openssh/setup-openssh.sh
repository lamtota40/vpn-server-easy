#!/bin/bash

apt-get install openssh-server -y

#Extra port openssh
cd
echo "Port 2222" >> /etc/ssh/sshd_config
echo "Port 2269" >> /etc/ssh/sshd_config
sed -i 's/#AllowTcpForwarding yes/AllowTcpForwarding yes/g' /etc/ssh/sshd_config
service ssh restart
service sshd restart


#apt-get purge openssh-server -y
