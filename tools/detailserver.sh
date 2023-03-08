#!/bin/bash

#apt install virt-what -y
if [ ! $(which jq) ]; then
   apt install jq -y
fi

clear
os_name=$(awk -F= '$1=="NAME" { print $2 ;}' /etc/os-release)
os_version=$(awk -F= '$1=="VERSION" { print $2 ;}' /etc/os-release)
raminfo=$(free -h | grep Mem)
core=$(awk -F: '/model name/ {core++} END {print core}' /proc/cpuinfo)
freq=$(awk -F: '/cpu MHz/ {freq=$2} END {print freq}' /proc/cpuinfo | sed 's/^[ \t]*//;s/[ \t]*$//')
#free -m
ram_free_p=$(free | grep Mem | awk '{print $4/$2 * 100}')
hddinfo=$(df -h --total | grep total)
private_ip=$(ip -4 addr | grep inet | grep -vE '127(\.[0-9]{1,3}){3}' | cut -d '/' -f 1 | grep -oE '[0-9]{1,3}(\.[0-9]{1,3}){3}' | sed -n "$ip_number"p)
cekip=$(curl -s "https://get.geojs.io/v1/ip/geo.json")
swapinfo=$(swapon --bytes)

echo "============= Time on server ============="
echo "Time =" `date "+%H:%M:%S"`
echo "Date =" `date "+%d/%m/%y"`
echo "Time Zone = $(timedatectl | grep -oP "(?<=Time zone:).*")"
echo "Uptime =" `uptime -p`

echo "============= Detail server ============="
echo "Hostname = $HOSTNAME"
echo "Ip Public = $(jq -r '.ip' <<< "$cekip") "
echo "Ip Private = $private_ip"
echo "ISP = $(jq -r '.organization_name' <<< "$cekip") | Country= $(jq -r '.country' <<< "$cekip")"
echo "Region= $(jq -r '.region' <<< "$cekip") | City= $(jq -r '.city' <<< "$cekip")"
echo "Virtualization = " `if grep -Eoc '(vmx|svm)' /proc/cpuinfo; then echo "(enable)"; else echo "(disable)"; fi`
echo "Type = $(systemd-detect-virt)"
echo "Architecture = $(uname -m)"
echo "OS = $os_name $os_version"
echo "Frimware = $([ -d /sys/firmware/efi ] && echo UEFI || echo BIOS)"
echo "Number of core = $core"
echo "CPU frequency = $freq MHz"
echo "Model name = $(lscpu | grep -oP "(?<=Model name:).*")"
echo "Kernel = $(hostnamectl | grep -oP "(?<=Kernel:).*")"
echo "RAM Free = $(awk '{print $4}' <<< "$raminfo") (${ram_free_p%.*} %) | Usage = $(awk '{print $3}' <<< "$raminfo") | Total = $(awk '{print $2}' <<< "$raminfo")"
echo "SWAP Free = $(awk 'FNR == 2 {print$3-$4}' <<< "$swapinfo" | numfmt --to=iec) (${ram_free_p%.*} %) | Usage = $(awk 'FNR == 2 {print$4}' <<< "$swapinfo" | numfmt --to=iec) | Total = $(awk 'FNR == 2 {print$3}' <<< "$swapinfo" | numfmt --to=iec)"
echo "HDD Free = $(awk '{print $4}' <<< "$hddinfo") | Usage = $(awk '{print $3}' <<< "$hddinfo") | Total = $(awk '{print $2}' <<< "$hddinfo")"
echo "========================================"
parted -l
echo "========================================"
