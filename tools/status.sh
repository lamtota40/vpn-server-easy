#!/bin/bash

if ! systemctl status dropbear &> /dev/null; then
    echo "[Failed] to install dropbear"
else
    echo "[OK] to install dropbear"
fi

if ! systemctl status squid &> /dev/null; then
    echo "[Failed] to install Squid"
else
    echo "[OK] to install Squid"
fi

if ! systemctl status sslh &> /dev/null; then
    echo "[Failed] to install sslh"
else
    echo "[OK] to install sslh"
fi

if ! systemctl status stunnel4 &> /dev/null; then
    echo "[Failed] to install stunnel4"
else
    echo "[OK] to install stunnel4"
fi

if ! systemctl status openvpn &> /dev/null; then
    echo "[Failed] to install openvpn"
else
    echo "[OK] to install openvpn"
fi

if ! systemctl status danted &> /dev/null; then
    echo "[Failed] to install danted"
else
    echo "[OK] to install danted"
fi

if ! systemctl status nginx &> /dev/null; then
    echo "[Failed] to install nginx"
else
    echo "[OK] to install nginx"
fi

if ! systemctl status server-sldns &> /dev/null; then
    echo "[Failed] to install server-slowdns"
else
    echo "[OK] to install server-slowdns"
fi

if ! systemctl status client-sldns &> /dev/null; then
    echo "[Failed] to install client-slowdns"
else
    echo "[OK] to install client-slowdns"
fi

rm -rf status.sh
