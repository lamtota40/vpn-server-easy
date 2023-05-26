#!/bin/bash

dateis=$(date +"%m-%d-%Y/%R")
echo "$dateis | Server sucessful reboot" >> /root/myvpn/log/logcron.txt
/sbin/shutdown -r now
