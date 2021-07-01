cat > /mnt/tmp/setup2.sh <<EOF
pacman -S sudo \
grub \
efibootmgr \
networkmanager \
nano \
$ucode

useradd "$newuname"
passwd "$newuname"
passwd
systemctl enable NetworkManager
usermod -aG wheel,audio,video,optical,storage $newuname
sed -i 's/# %wheel ALL=(ALL) NOPASSWD: ALL/%wheel ALL=(ALL) NOPASSWD: ALL/g' /etc/sudoers
ln -sf /usr/share/zoneinfo/Europe/London /etc/localtime
Set timezone
hwclock --systohc
sed -i '$ a 127.0.0.1 localhost' /etc/hosts
sed -i '$ a ::1 localhost' /etc/hosts
sed -i "$ a 127.0.0.1 $hname" /etc/hosts
cat /etc/hosts
echo "$hname" > /etc/hostname
cat /etc/hostname
sed -i 's/#en_GB.UTF-8 UTF-8/en_GB.UTF-8 UTF-8/g' /etc/locale.gen
locale-gen
mkdir /boot/EFI
mount /dev/"$dinstall"1 /boot/EFI
grub-install --target=x86_64-efi  --bootloader-id=arch_uefi --recheck
grub-mkconfig -o /boot/grub/grub.cfg
sed -i "/\[multilib\]/,/Include/"'s/^#//' /etc/pacman.conf
timedatectl set-ntp true
localectl set-keymap --no-convert uk
echo reboot PC and run app install script 

EOF
chmod +x /mnt/tmp/setup2.sh
