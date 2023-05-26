#!/bin/bash

dateis=$(date +"%m-%d-%Y/%R")
sync; echo 1 > /proc/sys/vm/drop_caches
swapoff -a && swapon -a
#du -sh /var/log/*
#truncate -s 0 /var/log/syslog
echo "$dateis | Execution Cron Clear Cache RAM" >> /root/myvpn/log/logclearcache.txt
