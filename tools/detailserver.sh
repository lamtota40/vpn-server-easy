#!/bin/bash

if [ ! $(which virt-what) ]; then
   apt install virt-what -y
fi
clear
os_name=$(awk -F= '$1=="NAME" { print $2 ;}' /etc/os-release)
os_version=$(awk -F= '$1=="VERSION" { print $2 ;}' /etc/os-release)
ram_usage=$(free -h | grep Mem | awk '{print $3}')
ram_free=$(free -h | grep Mem | awk '{print $4}')
ram_free_p=$(free | grep Mem | awk '{print $4/$2 * 100}')
ram_total=$(free -h | grep Mem | awk '{print $2}')
public_ip=$(grep -m 1 -oE '^[0-9]{1,3}(\.[0-9]{1,3}){3}$' <<< "$(wget -T 10 -t 1 -4qO- "http://ip1.dynupdate.no-ip.com/" || curl -m 10 -4Ls "http://ip1.dynupdate.no-ip.com/")")
private_ip=$(ip -4 addr | grep inet | grep -vE '127(\.[0-9]{1,3}){3}' | cut -d '/' -f 1 | grep -oE '[0-9]{1,3}(\.[0-9]{1,3}){3}' | sed -n "$ip_number"p)
cekip=$(curl -s "https://proxycheck.io/v2/$public_ip?vpn=1&asn=1")

echo "========= Time on server ========="
echo "Time =" `date "+%H:%M:%S"`
echo "Date =" `date "+%d/%m/%y"`
echo "Time Zone= "
echo "Uptime =" `uptime -p`

echo "========= Detail server ========="
echo "Hostname = $HOSTNAME"
echo "Ip Public = $public_ip"
echo "Ip Private = $private_ip"
echo "ISP = | City= | Country="
echo "Virtualization = " `if grep -Eoc '(vmx|svm)' /proc/cpuinfo; then echo "(enable)"; else echo "(disable)"; fi`
echo "Architecture = $(uname -m)"
echo "OS = $os_name $os_version"
echo "CPU = "
echo "RAM Free = $ram_free (${ram_free_p%.*} %) | Usage = $ram_usage | Total = $ram_total"
echo "HDD Free = Mb | Usage = Mb | Total = ram_total"
echo "=================================="
parted -l
echo "=================================="
echo "tes"
