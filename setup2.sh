


pacstrap /mnt base linux-firmware linux-zen git
genfstab -U /mnt >> /mnt/etc/fstab
echo -e "\e[36m
echo Your not logged into the new install ,
You will need to re-download the scripts ideally to /tmp using git clone https://github.com/8bitgrumpy/ainstall
\e[0m"
arch-chroot /mnt
