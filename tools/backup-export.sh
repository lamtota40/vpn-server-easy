#!/bin/bash

# File yang berisi data pengguna
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
