#!/bin/bash
echo -e "\e[36m

------------------------------------------
        BS's Arch Installer 
------------------------------------------

\e[0m"
echo -e "\e[33m  Enter Username to be created:\e[0m"
read -p ":" newuname
echo -e "\e[33m  Enter password:-\e[0m"
read -s newunamepwd1
echo -e "\e[33m  Enter password again:-\e[0m"
read -s newunamepwd2
if [ "$newunamepwd1" != "$newunamepwd2" ] ;
then
echo -e "\e[31m  Passwords do not match, re-run the script and try again !!!\e[0m"
exit
else 
echo -e "\e[32m  Passwords match. Will use the same password for root account !!!\e[0m"
fi
echo -e "\e[33m  select disk:-\e[0m"
dselect=($(lsblk -nd --output NAME))


PS3="Select Drive:"
driveschoice=("Drive 1 ${dselect[0]}" "Drive 2 ${dselect[1]}" "Drive 3 ${dselect[2]}" )
select dselected in "${driveschoice[@]}"
do
case $dselected in
"Drive 1 ${dselect[0]}")
dinstall="${dselect[0]}"
break
;;
"Drive 2 ${dselect[1]}")
dinstall="${dselect[1]}"
break
;;
"Drive 3 ${dselect[2]}")
dinstall="${dselect[2]}"
break
;;
*) ;;
esac
done
echo -e "\e[32m  Drive \e[0m \e[31m---"$dinstall"---\e[0m \e[32m selected. All data will be wiped!\e[0m"
read -p " Press w to continue. Any other key will exit this script. "
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

pacstrap /mnt base linux-firmware linux-zen git
genfstab -U /mnt >> /mnt/etc/fstab


