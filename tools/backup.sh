#!/bin/bash

domain=$(cat /root/myvpn/domain)
# File untuk menyimpan data pengguna
OUTPUT_FILE="data-users.txt"

# Menulis header ke file
echo "Username:Password:Expire:Blocked:Shell" > $OUTPUT_FILE

# Mengambil informasi pengguna
for user in $(awk -F: '$3 >= 1000 {print $1}' /etc/passwd); do
    # Mendapatkan informasi pengguna
    password=$(sudo grep "^$user:" /etc/shadow | cut -d: -f2)
    expire=$(sudo chage -l $user | grep "Account expires" | cut -d: -f2)
    blocked=$(sudo passwd -S $user | awk '{print $2}')
    shell=$(getent passwd $user | cut -d: -f7)

    # Menentukan status blokir
    if [ "$blocked" == "L" ]; then
        blocked_status="Yes"
    else
        blocked_status="No"
    fi

    # Menulis informasi pengguna ke file
    echo "$user:$password:$expire:$blocked_status:$shell" >> $OUTPUT_FILE
done
zip -P "abcd123" "data-user.zip" "data-user.txt"
cp data-users.zip /var/www/html/data-user.zip
rm data-users.zip

echo "Export completed. Data saved to $OUTPUT_FILE."
echo "OR for download http://"$domain":81/data-user.zip"

INPUT_FILE="data-users.txt"

# Membaca file baris per baris
while IFS=: read -r username password expire blocked shell; do
    # Membuat pengguna baru
    sudo useradd -m -s "$shell" "$username"

    # Mengatur password
    echo "$username:$password" | sudo chpasswd

    # Mengatur tanggal kedaluwarsa
    if [ "$expire" != "never" ]; then
        sudo chage -E "$expire" "$username"
    fi

    # Mengatur status blokir
    if [ "$blocked" == "Yes" ]; then
        sudo usermod -L "$username"
    else
        sudo usermod -U "$username"
    fi

done < "$INPUT_FILE"

echo "Import completed."
