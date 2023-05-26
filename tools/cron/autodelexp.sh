#!/bin/bash

dateis=$(date +"%m-%d-%Y/%T")
cat /etc/shadow | cut -d: -f1,8 | sed /:$/d > /tmp/listuser.txt
totalaccounts=`cat /tmp/listuser.txt | wc -l`
 for((i=1; i<=$totalaccounts; i++ ))
    do
    tuserval=`head -n $i /tmp/listuser.txt | tail -n 1`
    username=`echo $tuserval | cut -f1 -d:`
    userexp=`echo $tuserval | cut -f2 -d:`
    userexpireinseconds=$(( $userexp * 86400 ))
    tglexp=`date -d @$userexpireinseconds`             
    tgl=`echo $tglexp |awk -F" " '{print $3}'`
    while [ ${#tgl} -lt 2 ]
      do
      tgl="0"$tgl
    done
    while [ ${#username} -lt 15 ]
       do
       username=$username" " 
    done
bulantahun=`echo $tglexp |awk -F" " '{print $2,$3,$4}'`
todaystime=`date +%s`
if [ $userexpireinseconds -ge $todaystime ] ;
then
:
else
usermod -L $username
killall -u $username
userdel -f $username
echo "$dateis | Username $username | expired : $tgl $bulantahun removed" >> /root/myvpn/log/logdelexp.txt
fi
done
rm -f /tmp/listuser.txt
