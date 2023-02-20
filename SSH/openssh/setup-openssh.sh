#!/bin/bash

apt-get install openssh-server -y

#Extra port openssh
echo "Port 143" >> /etc/ssh/sshd_config
sed -i 's/#AllowTcpForwarding yes/AllowTcpForwarding yes/g' /etc/ssh/sshd_config
service ssh restart
service sshd restart


#apt-get purge openssh-server -y
