#!/bin/bash

dateis=$(date +"%m-%d-%Y/%R")
echo "$dateis | Server sucessful reboot" >> /root/myvpn/log/logcron.txt
truncate -s 0 /var/log/auth.log
/sbin/shutdown -r now
