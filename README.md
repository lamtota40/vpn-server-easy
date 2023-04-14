# vpn-server-easy
create vpn server easy

# Instalation
```console
wget n9.cl/vpnsetup -O setup-vpn.sh && bash setup-vpn.sh
```

-----------------------------------------------------<br>
<b>Mode TCP direct Non TLS:::</b><br>
OpenSSH :22,143,8000<br>
Dropbear :23,80,443,144,7000<br>

<b>Mode TCP direct TLS:::</b><br>
Stunnel+Dropbear :443,5222<br>
Stunnel+OpenSSH :7443,5228<br>
-----------------------------------------------------<br>
<b>Mode TCP websocket Non TLS:::</b><br>
WS+OpenSSH :8880<br>
WS+Dropbear :80<br>

<b>Mode TCP websocket TLS:::</b><br>
Stunnel+WS+OpenSSH :6443,944<br>
Stunnel+WS+Dropbear :443,955,5228<br>
-----------------------------------------------------<br>
<b>Mode Openvpn:::</b><br>
TCP OpenVPN :1194<br>
TCP WS+OpenVPN :80<br>
TCP Stunnel+OpenVPN :1194<br>
TCP Stunnel+WS+OpenVPN :443<br>
TCP OHP+OpenVPN :9088<br>
UDP OpenVPN :53,123,443<br>
-----------------------------------------------------<br>
<b>Mode OHP:::</b><br>
TCP OHP+Dropbear : <br>
TCP Stunnel+OHP+Dropbear : <br>
TCP WS+OHP+Dropbear : <br>
-----------------------------------------------------<br>
<b>PROXY:::</b><br>
shock4:4145<br>
shock5:1080<br>
Squid :3128,8080<br>
-----------------------------------------------------<br>
slowDNS:::<br>
NS Server :<br>
PUB Key :<br>
-----------------------------------------------------<br>
UDPGW/Badvpn :7200,7300<br>
WEB(NGIX) :81<br>

Auto reboot every day at 00:00<br>

<b>Mode V2ray:::</b><br>
-vmess<br>
-vless<br>
-shadowshock<br>

# TOOLS<br>
.
