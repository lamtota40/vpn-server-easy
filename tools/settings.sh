#!/bin/bash

echo "1. Change Timezone"
echo "2. Set limit login user"
echo "3. "Auto reboot"

#change timezone
timedatectl set-timezone Asia/Manila

# disable ipv6
echo 1 > /proc/sys/net/ipv6/conf/all/disable_ipv6
sed -i '$ i\echo 1 > /proc/sys/net/ipv6/conf/all/disable_ipv6' /etc/rc.local

