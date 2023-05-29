#!/bin/bash

dateis=$(date +"%d-%m-%Y/%R")
sync; echo 1 > /proc/sys/vm/drop_caches && swapoff -a && swapon -a
#Delete file log for more 1GB
count=$(find /var/log/* -type f -size +1000000000c | wc -l)
file=$(find /var/log/* -type f -size +1000000000c)
x=0
for (( i=1 ; i<=$count ; i++ )); 
do
     truncate -s 0 ${file[$x]}
     x=$(($x + 1))
done
echo "$dateis | Clear Cache RAM/SWAP/HDDlog" >> /root/myvpn/log/logcron.txt
