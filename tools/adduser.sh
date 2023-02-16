#!/bin/bash

read -p "input username     : " username
read -p "input password     : " password
read -p "Expired (yyyy-mm-dd) : " expired
#egrep "^$username" /etc/passwd >/dev/null
#if [ $? -eq 0 ]; then
     #echo  "Not created Username $username Already!"
     #exit 1
#else
     #pass=$(perl -e 'print crypt($ARGV[0], "password")' $password)
     #IP=`ifconfig venet0:0| awk 'NR==2 {print $2}'| awk -F: '{print $2}'`
     #useradd -e $expired -d /home/$username -m -g users -p $pass -s /bin/false $username
     #rm -r /home/$username
     #echo -e "===============\n$IP \nUser : $username\nPassword : $password\nExpired : $expired\n\n============\n"
#fi
