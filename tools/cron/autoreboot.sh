#!/bin/bash

s_date=$(date +"%m-%d-%Y")
s_time=$(date +"%T")
echo "$s_date / $s_time - Server sucessful reboot" >> /root/myvpn/cron/logcron.txt
/sbin/shutdown -r now
