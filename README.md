# vpn-server-easy
create vpn server easy

# Instalation
```console
wget n9.cl/vpnsetup -O setup-vpn.sh && bash setup-vpn.sh
```

Default port open:<br>
OpenSSH non TLS : 22 , 143, 8000<br>
Dropbear non TLS : 80 , 144, 8080<br>
(Stunnel+Dropbear) TLS : 443<br>
(Stunnel+OpenSSH) TLS : 995<br>
UDPGW/Badvpn : 7100, 7200, 7300<br>
WEB/NGIX : 81<br>

Auto reboot once day on 00:00

WS+Dropbear : 444
WS+SSL
WS+Ovpn : 445

SSH TLS/non+ slowDNS<br>
V2ray TLS/non+ slowDNS<br>

