#!/bin/bash

dateis=$(date +"%m-%d-%Y/%R")
truncate -s 0 /var/log/auth.log
/root/myvpn/cron/autoclearcache
journalctl --vacuum-size=500M
echo "$dateis | Server sucessful reboot" >> /root/myvpn/log/logcron.txt
/sbin/shutdown -r now
