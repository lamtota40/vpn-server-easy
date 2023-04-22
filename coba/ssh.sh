
sed -i 's/#PubkeyAuthentication .*/PubkeyAuthentication yes/g' /etc/ssh/sshd_config
sed -i 's/#AllowTcpForwarding yes/AllowTcpForwarding yes/g' /etc/ssh/sshd_config
sed -i 's/PasswordAuthentication .*/PasswordAuthentication yes/g' /etc/ssh/sshd_config
sed -i 's/#PermitEmptyPasswords .*/PermitEmptyPasswords yes/g' /etc/ssh/sshd_config
