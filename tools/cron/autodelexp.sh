#!/bin/bash

s_date=$(date +"%m-%d-%Y")
s_time=$(date +"%T")
echo "Server sucessful reboot date $s_date time $s_time" >> /root/myvpn/cron/logcron.txt
userdel -f -r $username
