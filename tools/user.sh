#!/bin/bash

echo "==================================="
read -p "input username     : " username
read -p "input password     : " password

pass=$(perl -e 'print crypt($ARGV[0], "password")' $password)
useradd -p $pass -M username
#rm -r /home/$username

echo "selesai"
