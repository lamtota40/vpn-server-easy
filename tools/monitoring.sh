#!/bin/bash

echo -e "Waktu pada server"
echo "jam =" date "+%H:%M:%S"
echo "tanggal =" date "%d/%m/%y"


FREE=`free -m | grep "buffers/cache" | awk '{print $3}'`
SWAP=`free -m | grep "Swap" | awk '{print $3}'`
UP=`uptime`

echo $FREE
echo $SWAP
echo $UP
echo "Created By : FreeDroid"
