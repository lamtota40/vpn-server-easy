#!/bin/bash
tanggal=$(date +"%m-%d-%Y")
waktu=$(date +"%T")
echo "Server sucessful reboot date $tanggal time $waktu." >> /root/log-reboot.txt
/sbin/shutdown -r now
