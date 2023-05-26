#!/bin/bash

s_date=$(date +"%m-%d-%Y")
s_time=$(date +"%T")
echo "$s_date / $s_time - Server sucessful reboot" >> /root/myvpn/log/logcron.txt
usermod -L $username
killall -u $username
userdel -f -r $username
