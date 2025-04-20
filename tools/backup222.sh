echo $(sudo grep $USER /etc/shadow | cut -f 2 -d ':') >/safe/encrypted-pass
sudo usermod -p $(cat /safe/encrypted-pass) $USER
