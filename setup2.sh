


pacstrap /mnt base linux-firmware linux-zen git
genfstab -U /mnt >> /mnt/etc/fstab
mkdir /mnt/tmp/ainstall
cp *.* /mnt/tmp/ainstall
arch-chroot /mnt
echo -e "\e[36m
echo Your not logged into the new install , scripts located at /tmp/ainstall
\e[0m"

