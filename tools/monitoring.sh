#!/bin/bash

get_public_ip=$(grep -m 1 -oE '^[0-9]{1,3}(\.[0-9]{1,3}){3}$' <<< "$(wget -T 10 -t 1 -4qO- "http://ip1.dynupdate.no-ip.com/" || curl -m 10 -4Ls "http://ip1.dynupdate.no-ip.com/")")

echo "=====Time on server====="
echo "Time =" `date "+%H:%M:%S"`
echo "Date =" `date "+%d/%m/%y"`
echo "Uptime ="

echo "=====Detail server====="
echo "Virtualization = " `grep -Eoc '(vmx|svm)' /proc/cpuinfo`
echo "OS = " `awk -F= '$1=="VERSION" { print $2 ;}' /etc/os-release`
echo "CPU = "
echo "RAM Usage = Mb | Free = Mb | Total = Mb"
echo "HHD Usage = Mb | Free = Mb | Total = Mb"
echo "Hostname = "
echo "Ip Public= $get_public_ip | Country= "
echo "Ip Private= "
