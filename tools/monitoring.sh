#!/bin/bash

public_ip=$(grep -m 1 -oE '^[0-9]{1,3}(\.[0-9]{1,3}){3}$' <<< "$(wget -T 10 -t 1 -4qO- "http://ip1.dynupdate.no-ip.com/" || curl -m 10 -4Ls "http://ip1.dynupdate.no-ip.com/")")
private_ip=$(ip -4 addr | grep inet | grep -vE '127(\.[0-9]{1,3}){3}' | cut -d '/' -f 1 | grep -oE '[0-9]{1,3}(\.[0-9]{1,3}){3}' | sed -n "$ip_number"p)

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
echo "Ip Public = $public_ip | Country= "
echo "Ip Private = $private_ip"
echo "=================================="
echo "ok"
