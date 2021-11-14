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
rsync \
signal-desktop \
xscreensaver \
speedtest-cli \
python3





#yay install
git clone https://aur.archlinux.org/yay.git
chown $user:$user ./yay
cd yay
makepkg -si
cd ..
rm -r -f ./yay/

yay -S  ttf-unifont
yay -S  siji-git
yay -S  ttf-font-awesome
yay -S  ttf-material-design-icons
yay -S  polybar
yay -S  brave

cp -r ./di_lite_config/Xauthority ~/.Xauthority
cp -r ./di_lite_config/bash_profile ~/.bash_profile
cp -r ./di_lite_config/bashrc ~/.bashrc
cp -r ./di_lite_config/xinitrc ~/.xinitrc
cp -r ./di_lite_config/xscreensaver ~/.xscreensaver
cp -rf ./di_lite_config/config/* ~/.config/
chmod +x ~/.config/bspwm/bspwmrc
chmod +x ~/.config/sxhkd/sxhkdrc
chmod +x ~/.config/polybar/launch.sh

yay -Scc --noconfirm
sudo pacman -Scc noconfirm




