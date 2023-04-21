#!/bin/bash

mkdir /etc/xray
mkdir /var/lib/crot
echo "IP=" >> /var/lib/crot/ipvps.conf
echo "Masukkan Domain Anda, Jika Anda Tidak Memiliki Domain Klik Enter"
echo "Ketikkan Perintah newhost setelah proses instalasi Script Selesai"
read -p "Hostname / Domain: " host
echo "IP="$host >> /var/lib/crot/ipvps.conf
echo "$host" >> /etc/xray/domain

domain=$(cat /etc/xray/domain)
apt install iptables iptables-persistent -y
apt install curl socat xz-utils wget apt-transport-https gnupg gnupg2 gnupg1 dnsutils lsb-release -y 
apt install socat cron bash-completion ntpdate -y
ntpdate pool.ntp.org
apt -y install chrony
timedatectl set-ntp true
systemctl enable chronyd && systemctl restart chronyd
systemctl enable chrony && systemctl restart chrony
timedatectl set-timezone Asia/Jakarta
chronyc sourcestats -v
chronyc tracking -v
date
