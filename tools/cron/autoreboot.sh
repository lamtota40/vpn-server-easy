#!/bin/bash

s_date=$(date +"%d-%m-%Y")
s_time=$(date +"%R")
echo "$s_date / $s_time - Server sucessful reboot" >> /root/myvpn/cron/logcron.txt
/sbin/shutdown -r now
