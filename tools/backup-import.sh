#!/bin/bash

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

echo "Export completed. Data saved to $OUTPUT_FILE."
