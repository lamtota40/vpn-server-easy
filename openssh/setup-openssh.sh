/etc/ssh/sshd_config

Cari tulisan #Port 22, ganti menjadi :
Port 22
Port 143

systemctl restart sshd
