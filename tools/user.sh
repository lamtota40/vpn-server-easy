#!/bin/bash

echo "==================================="
read -p "input username     : " username
read -p "input password     : " password

pass=$(perl -e 'print crypt($ARGV[0], "password")' $password)
useradd -d /home/$username -m -g users -p $pass -s /bin/false $username
#rm -r /home/$username

echo "selesai"
