user=$(whoami)

echo -e "\e[31m-----------------\e[0m"
echo -e "\e[31mBS Arch Install Script\e[0m"
echo -e "\e[31m----------------\e[0m"

echo -e "\e[35m-----------------\e[0m"
echo -e "\e[35mBase DTE installing ...... \e[35m"




sudo pacman -Sy
sudo pacman -S --noconfirm \
htop \
fakeroot \
minizip \
go \
base-devel \
xorg \
xorg-xinit \
ttf-dejavu \
sxhkd \
ranger \
dmenu \
bluez \
bluez-utils \
pulseaudio \
pavucontrol \
picom \
bspwm \
terminator \
samba \
feh \
rsync 





#yay install
git clone https://aur.archlinux.org/yay.git
chown $user:$user ./yay
cd yay
makepkg -si
cd ..
rm -r -f ./yay/

yay -S -nocleanmenu --nodiffmenu ttf-unifont \
siji-git \
ttf-font-awesome \
ttf-material-design-icons \
polybar \
brave-bin

cp ./di_lite_config/Xauthority ~/.Xauthority
cp ./di_lite_config/bash_profile ~/.bash_profile
cp ./di_lite_config/bashrc ~/.bashrc
cp ./di_lite_config/xinitrc ~/.xinitrc
cp ./di_lite_config/xscreensaver ~/.xscreensaver
cp ./di_lite_config/config ~/.config




sudo systemctl enable bluetooth.service



sudo pacman -Rsn --noconfirm  $(pacman -Qdtq)



