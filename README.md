# vpn-server-easy
create vpn server easy

# Instalation
```console
wget n9.cl/vpnsetup -O setup-vpn.sh && bash setup-vpn.sh
```

Mode TCP direct Non TLS:::<br>
OpenSSH :22,143,8000<br>
Dropbear :23,80,443,144,7000<br>
Mode TCP direct Non TLS:::<br>
Stunnel+Dropbear :8443,5222<br>
Stunnel+OpenSSH :7443,5228<br>

Mode TCP websocket Non TLS:::<br>
WS+OpenSSH :8880<br>
WS+Dropbear :80<br>

Mode TCP websocket TLS:::<br>
Stunnel+WS+OpenSSH :6443,944<br>
Stunnel+WS+Dropbear :443,955,5228<br>

UDPGW/Badvpn :7200,7300<br>
WEB(NGIX) :81<br>
OHP+Dropbear : <br>

Stunnel+OHP+Dropbear : <br>

TCP OpenVPN :1194<br>
TCP WS+OpenVPN :80<br>
TCP Stunnel+WS+OpenVPN :443<br>
TCP OHP+OpenVPN :9088<br>
UDP OpenVPN :53,443<br>

shock4:<br>
shock5:<br>
Squid :3128,8080<br>
Auto reboot every day at 00:00<br>

slowDNS<br>
NS Server :<br>
PUB Key :<br>

V2ray:<br>
-vmess<br>
-vless<br>
-shadowshock<br>

# TOOLS<br>
.
