#!/bin/bash

if ! systemctl status dropbear &> /dev/null; then
    printf "\n[Failed] to install dropbear\n"
else
    printf "\n[OK] to install dropbear\n"
fi

if ! systemctl status squid &> /dev/null; then
    printf "\n[Failed] to install Squid\n"
else
    printf "\n[OK] to install Squid\n"
fi

if ! systemctl status sslh &> /dev/null; then
    printf "\n[Failed] to install sslh\n"
else
    printf "\n[OK] to install sslh\n"
fi

if ! systemctl status stunel4 &> /dev/null; then
    printf "\n[Failed] to install stunel4\n"
else
    printf "\n[OK] to install stunel4\n"
fi

if ! systemctl status openvpn &> /dev/null; then
    printf "\n[Failed] to install openvpn\n"
else
    printf "\n[OK] to install openvpn\n"
fi

if ! systemctl status danted &> /dev/null; then
    printf "\n[Failed] to install danted\n"
else
    printf "\n[OK] to install danted\n"
fi

if ! systemctl status nginx &> /dev/null; then
    printf "\n[Failed] to install nginx\n"
else
    printf "\n[OK] to install nginx\n"
fi

if ! systemctl status server-sldns &> /dev/null; then
    printf "\n[Failed] to install server-slowdns\n"
else
    printf "\n[OK] to install server-slowdns\n"
fi

rm -rf status.sh
