# vpn-server-easy

vpn server easy<br>
Tested on 64bit ubuntu 18 & 20<br>
Minimum requiment :
- 1 vcpu
- 1 GB RAM
- 20 GB HDD

# Instalation
step 1:
```console
apt update && apt upgrade -y
```
step 2:
```console
wget n9.cl/vpnsetup -O setup-vpn.sh && bash setup-vpn.sh
```
OR
```console
apt install tmux -y
if tmux has-session -t setupvpn 2>/dev/null; then
tmux attach-session -t setupvpn
else
wget n9.cl/vpnsetup -O setup-vpn.sh && chmod +x setup-vpn.sh
tmux new-session -s setupvpn './setup-vpn.sh'
fi
```
username admin default for access OpenSSH,dropbear,Openvpn,shock5,slowdns,UDPcustom<br>
user: <b>master</b><br>
pass: <b>qwerty</b><br>
Note: For security you can delete this user type comand <br>
`userdel -f -r master`

# List Port

<b>Mode TCP direct Non TLS:::</b><br>
OpenSSH :22,143,8000<br>
Dropbear :23,144,7000<br>
SSLH+Dropbear : 443,5222,5228

<b>Mode TCP direct TLS:::</b><br>
SSLH &rarr; Stunnel &rarr; Dropbear : 443,5222,5228<br>
Stunnelarr;Dropbear :955,465<br>
Stunnel &rarr; OpenSSH :944,587<br>
-----------------------------------------------------<br>
<b>Mode TCP websocket Non TLS:::</b><br>
WS→OpenSSH :-<br>
WS→Dropbear :80,2082,8880<br>

<b>Mode TCP websocket TLS:::</b><br>
Stunnel→WS→OpenSSH :6443,944<br>
Stunnel→WS→Dropbear :000,000<br>
-----------------------------------------------------<br>
<b>Mode Openvpn:::</b><br>
TCP OpenVPN :1194<br>
TCP WS &rarr; OpenVPN :80<br>
TCP Stunnel→OpenVPN :995<br>
TCP SSLH→Stunnel→WS→OpenVPN :443<br>
TCP OHP→OpenVPN :9088<br>
UDP OpenVPN :53,123,443<br>
-----------------------------------------------------<br>
<b>Mode OHP:::</b><br>
TCP OHP→OpenSSH : 8080<br>
TCP OHP→Dropber : 8181<br>
TCP OHP→OpenVPN : 8282<br>
TCP Stunnel &rarr; OHP &rarr; Dropbear : <br>
TCP WS &rarr; OHP &rarr; Dropbear : <br>
-----------------------------------------------------<br>
<b>PROXY:::</b><br>
Socks5 :1080<br>
Squid :3128<br>
-----------------------------------------------------<br>
<b>Mode slowDNS:::</b><br>
NS Server :slow.yourdomain.com<br>
PUB Key :7fbd1f8aa0abfe15a7903e837f78aba39cf61d36f183bd604daa2fe4ef3b7b59<br>
Port SLOWDNS :22/ALl port<br>
-----------------------------------------------------<br>
-------------------<br>
<b>Mode UDP custom:::</b><br>
Port :1-65535<br>
-----------------------------------------------------<br>
UDPGW/Badvpn :7200,7300<br>
WEB(NGIX) :81 example: http://yourip:81<br>
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

<b>Auto cron Execution:::</b><br>
Auto reboot every day at 00:05<br>
Auto delete user every day at 00:15<br>
Auto clear cache every 4 hours<br>
<br>

# TOOLS Android
All in one Support: SSH,Openvpn,SlowDNS,UDPcustom,phisipon,V2Ray,TLS/Non TLS<br>
https://play.google.com/store/apps/details?id=xyz.easypro.httpcustom
<br><br>v2ray vpn<br>
https://play.google.com/store/apps/details?id=com.v2ray.ang
<br><br>proxy vpn<br>
https://play.google.com/store/apps/details?id=com.scheler.superproxy<br>
<br>shock vpn<br>
https://play.google.com/store/apps/details?id=net.typeblog.socks
