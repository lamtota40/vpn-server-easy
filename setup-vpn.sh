#!/bin/bash
echo "==================================="  
echo " Author: github.com/lamtota40
echo " Choose menu answer with number !"  
echo "==================================="
echo "1. Install Dropbear"
echo "2. Install Shadowshock"
echo "0. Quit"
echo "==================================="
read -p "choose [0-9]:" num
     until [[ -z "$num" || "$num" =~ ^[0-9]$ ]]; do
	echo "$num: invalid selection."
	read -p "choose [0-9]: " num
     done
case $num in  
    "1")  
        wget -qO- https://raw.githubusercontent.com/lamtota40/vpn-server-easy/main/dropbear/setup-dropbear.sh | bash
        ;;  
    "2")  
        echo "nothing"
        ;;
    "0")  
        exit 1
        ;;
esac
