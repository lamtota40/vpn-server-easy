#!/bin/bash

#sudo usermod {username} -s /sbin/nologin
clear
echo "Name : List Username SSH/OpenVPN/Socks/UDPcustom"
echo "---------------------------------------------------"
echo "USERNAME          EXP DATE               STATUS"
echo "---------------------------------------------------"
while read expired
do
AKUN="$(echo $expired | cut -d: -f1)"
ID="$(echo $expired | grep -v nobody | cut -d: -f3)"
exp="$(chage -l $AKUN | grep "Account expires" | awk -F": " '{print $2}')"
if [ "$exp" == "never" ]; then
exp="never   "
else
exp=$(date +%d/%m/%y -d "$exp")
fi

status="$(passwd -S $AKUN | awk '{print $2}' )"
if [[ $ID -ge 1000 ]]; then
if [[ "$status" = "L" ]]; then
printf "%-17s %2s %-17s %2s \n" "$AKUN" "$exp             " "${RED}BLOCK${NORMAL}"
else
printf "%-17s %2s %-17s %2s \n" "$AKUN" "$exp             " "${GREEN}UNBLOCK${NORMAL}"
fi
fi
done < /etc/passwd
JUMLAH="$(awk -F: '$3 >= 1000 && $1 != "nobody" {print $1}' /etc/passwd | wc -l)"
echo "---------------------------------------------------"
echo "Total Account: $JUMLAH User"
echo "---------------------------------------------------"
echo -e "1. Block User"
echo -e "2. UnBlock User"
echo -e "3. Extend Exp User"
echo -e "4. Delete User"
echo -e "0. Back to Menu"
echo "---------------------------------------------------"
read -p "Choose Options [0-4] :" num
case $num in
1)
read -p "Please input Username for Block :" usertoblock
if id "$usertoblock" &>/dev/null; then
	usermod -L $usertoblock
	echo "Ok Success Block Username = $usertoblock"
else
	echo "Failed Username Not Found"
fi
read -p "To continue Press Enter..."
/root/myvpn/listusers
;;
2)
read -p "Please input Username for UnBlock :" usertounblock
if id "$usertounblock" &>/dev/null; then
	usermod -U $usertounblock
	echo "Ok Success UnBlock Username = $usertounblock"
else
	echo "Failed Username Not Found"
fi
read -p "To continue Press Enter..."
/root/myvpn/listusers
;;
3)
read -p "Please input Username for Extend Expired :" usertoextend
if id "$usertoextend" &>/dev/null;
then
	cekexp=$(chage -l "$usertoextend" | grep 'Account expires' | cut -d ':' -f 2)
	echo "Account $usertoextend Expired at $(date +%d/%m/%y -d "$cekexp")"
	read -p "Please input in (Day) for Add extend Expired :" extend
	usermod -e $(date -d "$cekexp +$extend days" "+%Y-%m-%d") $usertoextend
else
	echo "Failed Username Not Found"
fi
read -p "To continue press [Enter]..."
/root/myvpn/listusers
;;
4)
read -p "Please input Username for delete :" usertodel
if id "$usertodel" &>/dev/null; then
	userdel $usertodel
	echo "Ok Success Delete Username = $usertodel"
else
	echo "Failed Username Not Found"
fi
read -p "To continue press [Enter]..."
/root/myvpn/listusers
;;
0)
/usr/sbin/menu
;;
esac
