count=$(grep "swap" /etc/fstab | wc -l)
if count -eq 0
sed -i '/swap/{s/^/#/}' tab
