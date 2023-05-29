#!/bin/bash

dateis=$(date +"%m-%d-%Y/%R")
sync; echo 1 > /proc/sys/vm/drop_caches && swapoff -a && swapon -a
#Delete file log for more 1GB
file=find /var/log/* -type f -size +1000000000c
count=$($data | wc -l)

count=$(du -bs /var/log/* | awk '$1 >= 1*(1024*1024*1024)' | wc -l)
file=( $(du -bs /var/log/* | awk '$1 >= 1*(1024*1024*1024)' | awk '{print $2}') )
x=0
for (( i=1 ; i<=$count ; i++ )); 
do
     truncate -s 0 ${file[$x]}
     x=$(($x + 1))
done
echo "$dateis | Execution Cron Clear Cache RAM/SWAP/HDDlog" >> /root/myvpn/log/logcron.txt
