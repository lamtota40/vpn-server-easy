#!/bin/bash

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
echo "Ip Public= | Country= "
echo "Ip Private= "
