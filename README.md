# vpn-server-easy
create vpn server easy

# Instalation
```console
wget n9.cl/vpnsetup -O setup-vpn.sh && bash setup-vpn.sh
```

Default TCP port open:<br>
SSH Non TLS:::<br>
OpenSSH :22,143,8000<br>
WS+OpenSSH :8880<br>
Dropbear :23,144,8080<br>
WS+Dropbear :80<br>
UDPGW/Badvpn :7200,7300<br>
WEB(NGIX) :81<br>

SSH TLS:::<br>
Stunnel+Dropbear :5222<br>
Stunnel+WS+Dropbear :443,955<br>
Stunnel+OpenSSH :5333<br>
Stunnel+WS+OpenSSH :8443,944<br>

http://myip:81/openvpn-tcp80.ovpn
http://myip:81/openvpn-tcp1194.ovpn
http://myip:81/openvpn-tcp443.ovpn
http://myip:81/openvpn-udp53.ovpn
http://myip:81/openvpn-ohp.ovpn
http://myip:81/openvpn-allconfig.zip

Squid :3128<br>
OHP :<br>
Auto reboot once day on 00:00<br>

slowDNS<br>
NS Server :<br>
PUB Key :<br>

# TOOLS<br>
