#!/bin/bash

apt install python -y

GIST="https://gist.githubusercontent.com/forphc/16f95185e2647d361c6ee07d690765af/raw/"

curl -skL "$GIST/ws-ssh.service" -o /lib/systemd/system/ws-ssh.service
curl -skL "$GIST/ws-stunnel.service" -o /lib/systemd/system/ws-stunnel.service
curl -skL "$GIST/ws-ovpn.service" -o /lib/systemd/system/ws-ovpn.service
curl -skL "$GIST/ws-ssh.py" -o /usr/local/bin/ws-ssh.py
curl -skL "$GIST/ws-stunnel.py" -o /usr/local/bin/ws-stunnel.py
curl -skL "$GIST/ws-ovpn.py" -o /usr/local/bin/ws-ovpn.py

systemctl daemon-reload
systemctl enable ws-ssh.service  &> /dev/null
systemctl enable ws-stunnel.service  &> /dev/null
systemctl enable ws-ovpn.service  &> /dev/null
systemctl start ws-ssh.service
systemctl start ws-stunnel.service
systemctl start ws-ovpn.service

if ! systemctl status ws-ssh.service &> /dev/null; then
	clear
	printf "\nFailed to start no-load\n"
elif ! systemctl status ws-stunnel.service &> /dev/null; then
	clear
	printf "\nFailed to start no-load\n"
elif ! systemctl status ws-ovpn.service &> /dev/null; then
	clear
	printf "\nFailed to start no-load\n"
else
	clear
	printf "\nNo-load started\n"
  printf "\nWebsocket DropbearSSH port: 80\n"
  printf "\nWebsocket Stunnel/SSL port: 443\n"  
  printf "\nWebsocket Ovpn port: 99\n\n"
fi
