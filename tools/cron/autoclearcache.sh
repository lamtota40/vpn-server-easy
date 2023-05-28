#!/bin/bash

dateis=$(date +"%m-%d-%Y/%R")
sync; echo 1 > /proc/sys/vm/drop_caches
swapoff -a && swapon -a
journalctl --vacuum-size=500M
#du -sh /var/log/*
#truncate -s 0 /var/log/syslog
#du -bs /var/log/* | awk '$1 >= 1*(1024*1024*1024)' | awk '{print $2}' | awk 'NR==1'
count=$(`du -bs /var/log/* | awk '$1 >= 1*(1024*1024*1024)' | wc -l`)
for (( i=1 ; i<=$count ; i++ )); 
do
    echo $i
done

#truncate -s 0 $file
echo "$dateis | Execution Cron Clear Cache RAM/SWAP/HDDlog" >> /root/myvpn/log/logcron.txt
