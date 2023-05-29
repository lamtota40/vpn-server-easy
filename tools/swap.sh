grep "swap" /etc/fstab | wc -l
sed -i '/swap/{s/^/#/}' tab
