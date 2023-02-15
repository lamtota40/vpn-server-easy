#!/bin/bash

echo "=====Time on server====="
echo "Time =" `date "+%H:%M:%S"`
echo "Date =" `date "+%d/%m/%y"`
echo "Uptime ="

echo "=====Detail server====="
echo "Virtualization = " `grep -Eoc '(vmx|svm)' /proc/cpuinfo`
echo "OS = " 'awk -F= '$1=="VERSION" { print $2 ;}' /etc/os-release`
echo "CPU = "
echo "RAM Usage = Mb | Free = Mb | Total ="
echo "HHD Usage = Mb | Free = Mb | Total ="
echo "Hostname = "
echo "Ip Public= "
echo "Ip Private= "

FREE=`free -m | grep "buffers/cache" | awk '{print $3}'`
SWAP=`free -m | grep "Swap" | awk '{print $3}'`
UP=`uptime`

echo $FREE
echo $SWAP
echo $UP
echo "Created By : FreeDroid"
