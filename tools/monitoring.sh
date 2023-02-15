#!/bin/bash

echo "=====Time on server====="
echo "Time =" date "+%H:%M:%S"
echo "Date =" date "%d/%m/%y"
echo "Uptime server =" `uptime`

FREE=`free -m | grep "buffers/cache" | awk '{print $3}'`
SWAP=`free -m | grep "Swap" | awk '{print $3}'`
UP=`uptime`

echo $FREE
echo $SWAP
echo $UP
echo "Created By : FreeDroid"
