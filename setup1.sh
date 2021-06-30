echo -e "\e[36m


Setup Disk Partitions use "fdisk"
select G for GPT
EFI partion size should be 512M
dont bother with sap if over 16GB of ram . 


Make filesystem example :
mkfs.fat -F32 /dev/sda1
mkswap /dev/sda2
swapon /dev/sda2
mkfs.ext4 /dev/sda3

mount /dev/mainuserpartition /mnt
run the packstrap script.

\e[0m"
