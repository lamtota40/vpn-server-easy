#!/bin/bash

dateis=$(date +"%m-%d-%Y/%T")
echo "$dateis | Server sucessful reboot" >> /root/myvpn/log/logcron.txt
/sbin/shutdown -r now
