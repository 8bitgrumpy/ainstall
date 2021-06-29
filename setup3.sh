


pacstrap /mnt base linux-firmware linux-zen
genfstab -U /mnt >> /mnt/etc/fstab 
-e "\e[36m
echo now arch-chroot /mnt and run the setup script 
\e[0m"

