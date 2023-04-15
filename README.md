# vpn-server-easy
create vpn server easy

# Instalation
```console
wget n9.cl/vpnsetup -O setup-vpn.sh && bash setup-vpn.sh
```

-----------------------------------------------------<br>
<b>Mode TCP direct Non TLS:::</b><br>
OpenSSH :22,143,8000<br>
Dropbear :23,144,7000<br>
SSLH+Dropbear : 443,5222,5228

<b>Mode TCP direct TLS:::</b><br>
SSLH+Stunnel+Dropbear : 443,5222,5228<br>

Stunnel+Dropbear :955,465<br>
Stunnel+OpenSSH :944,587<br>
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
shock4 :4145<br>
shock5 :1080<br>
Squid :3128,8080<br>
-----------------------------------------------------<br>
<b>Mode slowDNS:::</b><br>
NS Server :slow-id.xxxxx.com<br>
PUB Key :7fbd1f8aa0abfe15a7903e837f78aba39cf61d36f183bd604daa2fe4ef3b7b59<br>
Port SLOWDNS :ALL Port OpenSSH<br>
-----------------------------------------------------<br>
UDPGW/Badvpn :7200,7300<br>
WEB(NGIX) :81<br>
-----------------------------------------------------<br>
<b>Mode V2ray TCP non TLS:::</b><br>
trojan:<br>
shadowshock:<br>

TCP vmess: <br>
TCP vless: <br>
TCP WS+vmess: <br>
TCP WS+vless: <br>
TCP KCP+vmess: <br>
TCP KCP+vless: <br>
TCP QUIC+vmess: <br>
TCP QUIC+vless: <br>
TCP GRPC+vmess: <br>
TCP GRPC+vless: <br>
TCP H2+vmess: <br>
TCP H2+vless: <br>

<b>Mode V2ray TCP TLS:::</b><br>
TCP Stunnel+vmess: <br>
TCP Stunnel+vless: <br>
TCP XTLS+vmess: <br>
TCP XTLS+vless: <br>
-----------------------------------------------------<br>

Auto reboot every day at 00:00<br>

# TOOLS<br>
.
