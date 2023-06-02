#!/bin/bash

dateis=$(date +"%d-%m-%Y/%R")
truncate -s 0 /var/log/auth.log
truncate -s 0 /var/log/syslog
/root/myvpn/cron/autoclearcache
journalctl --vacuum-size=100M
echo "$dateis | Server sucessful reboot" >> /root/myvpn/log/logcron.txt
/sbin/shutdown -r now
