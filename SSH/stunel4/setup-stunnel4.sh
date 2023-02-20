apt install -y stunnel4
curl -skL "$GIST/stunnel.conf" -o /etc/stunnel/stunnel.conf
curl -skL "$GIST/stunnel.pem" -o /etc/stunnel/stunnel.pem
sed -i 's/ENABLED=0/ENABLED=1/g' /etc/default/stunnel4
systemctl restart stunnel4
if ! systemctl status stunnel4 &> /dev/null; then
   printf "\nFailed to install Stunnel4\n" && err
fi
