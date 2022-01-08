#!/bin/bash
echo -e "\e[36m
------------------------------------------
        Brendan's Luxury Arch Installer 
------------------------------------------
\e[0m"

sed -i 's/#ParallelDownloads = 5/ParallelDownloads = 20/g' /etc/pacman.conf
sed -i '/^#VerbosePkgLists/a ILoveCandy' /etc/pacman.conf
sed -i 's/#Color/Color/g' /etc/pacman.conf
#Set username + hostname var

echo -e "\e[33m  Enter Hostname to be created:\e[0m"
read -p ":" hname
echo -e "\e[33m  Enter Username to be created:\e[0m"
read -p ":" newuname
echo -e "\e[33m  Enter password:-\e[0m"

# set install destination var 

echo -e "\e[33m  select disk:-\e[0m"
dselect=($(lsblk -nd --output NAME))

PS3="Select Drive:"
driveschoice=("${dselect[@]}")
select dselected in "${driveschoice[@]}"
do
case $dselected in
"${dselect[0]}")
dinstall="${dselect[0]}"
ddrive="${dselect[0]}"
break
;;
"${dselect[1]}")
dinstall="${dselect[1]}"
ddrive="${dselect[1]}"
break
;;
"${dselect[2]}")
dinstall="${dselect[2]}"
ddrive="${dselect[2]}"
break
;;
"${dselect[3]}")
dinstall="${dselect[3]}"
ddrive="${dselect[3]}"
break
;;
"${dselect[4]}")
dinstall="${dselect[4]}"
ddrive="${dselect[4]}"
break
;;
"${dselect[5]}")
dinstall="${dselect[5]}"
ddrive="${dselect[5]}"
break
;;
*) ;;
esac
done
# postfix nvme drives with p as diffrent partition naming format to sata 
STR="$dinstall"
SUB='nvme'
if [[ "$STR" == *"$SUB"* ]]; then
dinstall="$dinstall"p
fi
echo $dinstall
# set processor var
PS3="CPU Processor:"
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

## set GPU var
#PS3="GPU Processor:"
#gpuc=("NVIDIA" "ONBOARD")
#select gpuselected in "${gpuc[@]}"
#do
#case $gpuselected in
#"${gpuselected[0]}")
#gpup="${gpuselected[0]}"
#break
#;;
#"${gpuselected[1]}")
#gpup="${gpuselected[1]}"
#break
#;;
#*) ;;
#esac
#done

#if [ "$gpup" = "NVIDIA" ] ;
#then
#gpu="nvidia"
#gpus="nvidia-settings"
#else 
#gpu=""
#fi


# confirm before instal

echo -e "\e[32m  Username:  =  \e""[0m \e[31m"$newuname"\e[0m"
echo -e "\e[32m  Drive to be wiped : =  \e""[0m \e[31m"$dinstall"\e[0m"
echo -e "\e[32m  CPU Processor type : =  \e""[0m \e[31m"$cpup"\e[0m"

read -p " Press w to continue No going back at this point. Any other key will exit this script. "
if [ "$REPLY" != "w" ]; then
exit
fi
echo -e "\e[31m  Drive "$dinstall" set to be wiped . No going back!! \e[0m"
#### Partitioning
dd if=/dev/zero of=/dev/"$ddrive" bs=1M status=progress count=12000
# Set the partition table to GPT
parted -s /dev/$ddrive mklabel gpt

# Remove any older partitions
parted -s /dev/$ddrive rm 1 &> /dev/null
parted -s /dev/$ddrive rm 2 &> /dev/null
parted -s /dev/$ddrive rm 3 &> /dev/null
parted -s /dev/$ddrive rm 4 &> /dev/null

# Create boot partition
echo "Create boot partition"
parted -s /dev/$ddrive mkpart primary fat32 1MiB 550MiB
parted -s /dev/$ddrive set 1 esp on

# Create swap partition
echo "Create swap partition"
parted -s /dev/$ddrive mkpart primary linux-swap 550MiB 6694MiB

# Create root partition
echo "Create root partition"
parted -s /dev/$ddrive mkpart primary f2fs 6694MiB 100%


mkfs.fat -F32 /dev/"$dinstall"1
mkswap /dev/"$dinstall"2
swapon /dev/"$dinstall"2
mkfs.ext4 /dev/"$dinstall"3
echo -e "\e[33m  Drives Created & formatted. Running packstrap :\e[0m"
# pacstrap base components 
mount /dev/"$dinstall"3 /mnt
pacstrap /mnt base \
linux-firmware \
linux-zen \
linux-zen-headers \

# createing fstab to mount drives on boot
genfstab -U /mnt >> /mnt/etc/fstab

# creating second stage install script based on var's set above
cat > /mnt/setup2.sh <<EOF
# --- second stage install script #
# install base components for sudo , bootloader and shell
#pacman multi download mode 
sed -i 's/#ParallelDownloads = 5/ParallelDownloads = 20/g' /etc/pacman.conf
sed -i '/^#VerbosePkgLists/a ILoveCandy' /etc/pacman.conf
sed -i 's/#Color/Color/g' /etc/pacman.conf
#Set username + hostname var

# Install boot programs
pacman -Sy --noconfirm \
grub

# insall sudo
pacman -Sy --noconfirm \
sudo

# insall editors
pacman -Sy --noconfirm \
nano \
vim


# insall drivers
pacman -Sy --noconfirm \
nvidia-dkms \
amd-ucode

# install bspwm
pacman -Sy --noconfirm \
bspwm \
feh \
terminator \
pulseaudio \
pavucontrol \
udiskie \
sxhkd \
xorg \
xorg-xinit \
ttf-dejavu \
dmenu

# install bluetooth
pacman -Sy --noconfirm \
bluez \
bluez-utils
# enable bluetooth service
systemctl enable bluetooth.service

# install misc tools
pacman -Sy --noconfirm \
unzip \
htop \
neofetch \
rsync

#Install paru
cd /tmp
pacman -Sy --noconfirm --needed base-devel
git clone https://aur.archlinux.org/paru.git
cd paru
makepkg -si

paru -S --noconfirm  ttf-unifont
paru -S --noconfirm  siji-git
paru -S --noconfirm  ttf-font-awesome
paru -S --noconfirm  ttf-material-design-icons
paru -S --noconfirm  polybar
paru -S --noconfirm  brave
paru -S --noconfirm dracula-gtk-theme
paru -S --noconfirm xscreensaver-arch-logo

# set user passwords
echo -e "\e[32m  Creating user:  =  \e""[0m \e[31m"$newuname"\e[0m"
useradd -m "$newuname"
passwd "$newuname" x
echo -e "\e[32m  Set password for:  =  \e""[0m \e[31m"root"\e[0m"
passwd x
# add user to default groups
usermod -aG wheel,audio,video,optical,storage $newuname
# set sudo to no password
sed -i 's/# %wheel ALL=(ALL) NOPASSWD: ALL/%wheel ALL=(ALL) NOPASSWD: ALL/g' /etc/sudoers
# set timezone
ln -sf /usr/share/zoneinfo/Europe/London /etc/localtime
hwclock --systohc
# set hosts and localhost files 
sed -i '$ a 127.0.0.1 localhost' /etc/hosts
sed -i '$ a ::1 localhost' /etc/hosts
sed -i "$ a 127.0.0.1 $hname" /etc/hosts
cat /etc/hosts
echo "$hname" > /etc/hostname
cat /etc/hostname
# set locale
sed -i 's/#en_GB.UTF-8 UTF-8/en_GB.UTF-8 UTF-8/g' /etc/locale.gen
locale-gen
# create bootloader
mkdir /boot/EFI
mount /dev/"$dinstall"1 /boot/EFI
grub-install --target=x86_64-efi  --bootloader-id=arch_uefi --recheck
sed -i '$ a GRUB_FORCE_HIDDEN_MENU="true"' /etc/default/grub
git clone https://github.com/8bitgrumpy/ainstall
cp -rf ./ainstall/31_hold_shift /etc/grub.d
chmod a+x /etc/grub.d/31_hold_shift
rm-r ainstall
grub-mkconfig -o /boot/grub/grub.cfg
sed -i "/\[multilib\]/,/Include/"'s/^#//' /etc/pacman.conf

set timezone
timedatectl set-ntp true
# set to uk keymap 
echo "KEYMAP=uk" > /etc/vconsole.conf
git clone https://github.com/8bitgrumpy/ainstall
cd ainstall
cp -r ./di_lite_config/Xauthority /home/$newuname/.Xauthority
cp -r ./di_lite_config/bash_profile /home/$newuname/.bash_profile
cp -r ./di_lite_config/bashrc /home/$newuname/.bashrc
cp -r ./di_lite_config/xinitrc /home/$newuname/.xinitrc
cp -r ./di_lite_config/xscreensaver /home/$newuname/.xscreensaver
cp -rf ./di_lite_config/config/* /home/$newuname/.config/
chmod +x /home/$newuname/.config/bspwm/bspwmrc
chmod +x /home/$newuname/.config/sxhkd/sxhkdrc
chmod +x /home/$newuname/.config/polybar/launch.sh
chmod +x /home/$newuname/.config/polybar/scripts/speedtest/polybar-speedtest

unzip Dracula.zip
sudo cp -R Dracula /usr/share/icons/
sudo pacman -Scc noconfirm

EOF

# copy generated second stage script to chroot , run + tidyup. 
chmod +x /mnt/setup2.sh
arch-chroot /mnt ./setup2.sh
rm /mnt/setup2.sh
echo You should be good to reboot... with luck..




