#!/bin/bash
echo -e "\e[36m
loadkeys uk
------------------------------------------
        Brendan's Luxury Arch Installer 
------------------------------------------

\e[0m"
echo -e "\e[33m  Enter Hostname to be created:\e[0m"
read -p ":" hname
echo -e "\e[33m  Enter Username to be created:\e[0m"
read -p ":" newuname
echo -e "\e[33m  Enter password:-\e[0m"

echo -e "\e[33m  select disk:-\e[0m"
dselect=($(lsblk -nd --output NAME))


PS3="Select Drive:"
driveschoice=("${dselect[@]}")
select dselected in "${driveschoice[@]}"
do
case $dselected in
"${dselect[0]}")
dinstall="${dselect[0]}"
break
;;
"${dselect[1]}")
dinstall="${dselect[1]}"
break
;;
"${dselect[2]}")
dinstall="${dselect[2]}"
break
;;
*) ;;
esac
done
PS3="Select Processor:"
cpuc=("AMD" "INTEL")
select cpuselected in "${cpuc[@]}"
do
case $cpuselected in
"${cpuselected[0]}")
cpup="${cpuselected[0]}"
break
;;
"${cpuselected[1]}")
cpup="${cpuselected[1]}"
break
;;
*) ;;
esac
done

if [ "$cpup" = "AMD" ] ;
then
ucode="amd-ucode"
else 
ucode="intel-ucode"
fi


echo -e "\e[32m  Username:  =  \e""[0m \e[31m"$newuname"\e[0m"
echo -e "\e[32m  Drive to be wiped : =  \e""[0m \e[31m"$dinstall"\e[0m"
echo -e "\e[32m  CPU Processor type : =  \e""[0m \e[31m"$cpup"\e[0m"

read -p " Press w to continue No going back at this point. Any other key will exit this script. "
if [ "$REPLY" != "w" ]; then
exit
fi
echo -e "\e[31m  Drive "$dinstall" set to be wipped . No going back \e[0m"
dd if=/dev/zero of=/dev/"$dinstall" bs=1M status=progress

echo "
g
n
1
2048
+550M
t
1
n
2

+6G
t
2
19
n
3


w" | fdisk /dev/"$dinstall"
mkfs.fat -F32 /dev/"$dinstall"1
mkswap /dev/"$dinstall"2
swapon /dev/"$dinstall"2
mkfs.ext4 /dev/"$dinstall"3
echo -e "\e[33m  Drives Created & formatted. Running packstrap :\e[0m"
mount /dev/"$dinstall"3 /mnt
pacstrap /mnt base linux-firmware linux-zen git
genfstab -U /mnt >> /mnt/etc/fstab

cat > /mnt/setup2.sh <<EOF

pacman -Sy --noconfirm sudo grub efibootmgr networkmanager nano $ucode

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
chmod +x /mnt/setup2.sh
arch-chroot /mnt ./setup2.sh
rm /mnt/setup2.sh
reboot





