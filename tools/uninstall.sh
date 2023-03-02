#!/bin/bash

echo "1. All"
echo "2. Dropbear"
echo "3. OpenSSH"
echo "3. Stunnel4"
echo "4. Squid"
echo "5. openvpn"
echo "6. "

apt purge dropbear -y
	
rm -f /etc/cron.d/autoreboot
