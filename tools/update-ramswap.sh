#!/bin/bash

# Meminta input dari pengguna
read -p "Masukkan ukuran swap baru (misalnya 2G, 4G): " swap_size
read -p "Masukkan nilai swappiness baru (0-100): " swappiness
read -p "Masukkan nilai vfs_cache_pressure baru: " vfs_cache_pressure

# Mematikan swap yang ada
sudo swapoff /swapfile

# Mengubah ukuran swap
sudo fallocate -l $swap_size /swapfile
sudo chmod 600 /swapfile
sudo mkswap /swapfile
sudo swapon /swapfile

# Memperbarui /etc/fstab jika perlu
if ! grep -q '/swapfile' /etc/fstab; then
    echo '/swapfile none swap sw 0 0' | sudo tee -a /etc/fstab
fi

# Memperbarui sysctl.conf
sudo cp /etc/sysctl.conf /etc/sysctl.conf.bak
sudo sed -i "/^vm.swappiness/d" /etc/sysctl.conf
sudo sed -i "/^vm.vfs_cache_pressure/d" /etc/sysctl.conf
echo "vm.swappiness=$swappiness" | sudo tee -a /etc/sysctl.conf
echo "vm.vfs_cache_pressure=$vfs_cache_pressure" | sudo tee -a /etc/sysctl.conf

# Menerapkan pengaturan baru
sudo sysctl -p

echo "Swap, swappiness, dan vfs_cache_pressure telah diperbarui."
