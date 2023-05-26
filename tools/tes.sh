#!/bin/bash
data=( `ps aux | grep -i udpc | awk '{print $2}'`);
echo "Checking User UDPcustom logged in";
echo "(PID - Username - IP)";
echo "-----------------------------------------";
a=b=0
for PID in "${data[@]}"
do
#echo "check $PID";
NUM=`cat /var/log/auth.log | grep -i udp-custom | grep -i "Password auth succeeded" | grep "dropbear\[$PID\]" | wc -l`;
USER=`cat /var/log/auth.log | grep -i dropbear | grep -i "Password auth succeeded" | grep "dropbear\[$PID\]" | awk '{print $10}'`;
IP=`cat /var/log/auth.log | grep -i dropbear | grep -i "Password auth succeeded" | grep "dropbear\[$PID\]" | awk '{print $12}'`;
if [ $NUM -eq 1 ]; then
a=$((a+1))
echo "$PID - $USER - $IP";
fi
done
echo "Total User Used Service Dropbear = $a"
