count=$(grep "swap" /etc/fstab | wc -l)
if [[ $count -eq 0 ]]
then
sed -i '/swap/{s/^/#/}' tab
else

fi
