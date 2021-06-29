
read -p "Coose a username : " usrname
useradd -m $usrname
passwd $usrname
echo -e "\e[31mSet Root password\e[0m"
passwd
pacman -S sudo \
grub \
efibootmgr \
amd-ucode
usermod -aG wheel,audio,video,optical,storage $usrname
sed -i 's/# %wheel ALL=(ALL) NOPASSWD: ALL/%wheel ALL=(ALL) NOPASSWD:/g' ALL/etc/sudoers
echo Set timezone
ln -sf /usr/share/zoneinfo/Europe/London /etc/localtime
hwclock --systohc
read -p "Choose hostname: " hname
sed -i '$ a 127.0.0.1 localhost' /etc/hosts
sed -i '$ a ::1 localhost' /etc/hosts
sed -i "$ a 127.0.0.1 $hname" /etc/hosts
cat /etc/hosts
touch /etc/hostname
sed -i "$ a $hname" /etc/hostname
cat /etc/hostname
sed -i 's/#en_GB.UTF-8 UTF-8/en_GB.UTF-8 UTF-8/g' /etc/locale.gen
locale-gen
mkdir /etc/boot/EFI
fdisk -l 
echo -e "\e[31mTake note of EFI partition!\e[0m"
read -p "Enter efi partition: " efipart
mount /dev/$efipart /boot/EFI
grub-install --target=x86_64-efi --bootloader-id=grub_$hnme --recheck
grub-mkconfig -o /boot/grub.cfg
sed -i 's/#[multilib]/[multilib]/g /etc/pacman.conf
sed -i 's/#Include = /etc/pacman.d/mirrorlist/Include = /etc/pacman.d/mirrorlist/g /etc/pacman.conf


echo reboot PC and run app install script 


