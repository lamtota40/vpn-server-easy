#!/bin/bash
 
clear
echo "=========================================";
 
data=( `ps aux | grep -i dropbear | awk '{print $2}'`);
echo "Checking User Dropbear logged in";
echo "(PID - Username - IP)";
echo "-----------------------------------------";
a=b=0
for PID in "${data[@]}"
do
#echo "check $PID";
NUM=`cat /var/log/auth.log | grep -i dropbear | grep -i "Password auth succeeded" | grep "dropbear\[$PID\]" | wc -l`;
USER=`cat /var/log/auth.log | grep -i dropbear | grep -i "Password auth succeeded" | grep "dropbear\[$PID\]" | awk '{print $10}'`;
IP=`cat /var/log/auth.log | grep -i dropbear | grep -i "Password auth succeeded" | grep "dropbear\[$PID\]" | awk '{print $12}'`;
if [ $NUM -eq 1 ]; then
a=$((a+1))
echo "$PID - $USER - $IP";
fi
done
echo "Total User Used Service Dropbear = $a"
 
data=( `ps aux | grep "\[priv\]" | sort -k 72 | awk '{print $2}'`);
echo "";
echo "Checking User OpenSSH/SlowDNS logged in";
echo "(PID - Username - IP)";
echo "-----------------------------------------";
for PID in "${data[@]}"
do
#echo "check $PID";
NUM=`cat /var/log/auth.log | grep -i sshd | grep -i "Accepted password for" | grep "sshd\[$PID\]" | wc -l`;
USER=`cat /var/log/auth.log | grep -i sshd | grep -i "Accepted password for" | grep "sshd\[$PID\]" | awk '{print $9}'`;
IP=`cat /var/log/auth.log | grep -i sshd | grep -i "Accepted password for" | grep "sshd\[$PID\]" | awk '{print $11}'`;
if [ $NUM -eq 1 ]; then
b=$((b+1))
echo "$PID - $USER - $IP";
fi
done
echo "Total User Used Service OpenSSH/SlowDNS = $b"

echo "";
echo "Checking User UDPcustom logged in";
echo "(PID - Username - IP)";
echo "-----------------------------------------";
echo "Total User Used Service UDPcustom = 0"
echo "=========================================";


echo "";
echo "Checking User OpenVPN logged in";
echo "(PID - Username - IP)";
echo "-----------------------------------------";
echo "Total User Used Service OpenVPN = 0"
echo "=========================================";
