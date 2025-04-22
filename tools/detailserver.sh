#!/bin/bash

#apt install virt-what -y
if [ ! $(which jq) ]; then
   apt install jq -y
fi

clear
private_ip=$(ip -4 addr | grep inet | grep -vE '127(\.[0-9]{1,3}){3}' | cut -d '/' -f 1 | grep -oE '[0-9]{1,3}(\.[0-9]{1,3}){3}' | sed -n "$ip_number"p)
cekip=$(curl -s "https://get.geojs.io/v1/ip/geo.json")
swapinfo=$(swapon --bytes)

echo "============= Time on server ============="
echo "Time =" `date "+%H:%M"` " | "`date "+%d/%m/%y"`
echo "Time Zone = $(timedatectl | grep -oP "(?<=Time zone:).*")"
echo "Uptime =" `uptime -p`

echo "============= Detail server ============="
echo "Hostname = $HOSTNAME"
echo "Ip Public IPV4= $(wget -4qO- ipinfo.io/ip) "
echo "Ip Public IPv6= $(jq -r '.ip' <<< "$cekip") "
echo "Ip Private = $private_ip"
echo "Virtualization = " `if grep -Eoc '(vmx|svm)' /proc/cpuinfo; then echo "(enable)"; else echo "(disable)"; fi`
echo "Frimware = $([ -d /sys/firmware/efi ] && echo UEFI || echo BIOS)"
echo "Model name = $(lscpu | grep -oP "(?<=Model name:).*" | sed 's/^[ \t]*//;s/[ \t]*$//')"
echo "Kernel = $(hostnamectl | grep -oP "(?<=Kernel:).*")"
echo "========================================"
parted -l
echo "========================================"
