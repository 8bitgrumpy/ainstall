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
bspwm




#yay install
git clone https://aur.archlinux.org/yay.git
chown $user:$user ./yay
cd yay
makepkg -si
cd ..
rm -r -f ./yay/

yay -S ttf-unifont \
siji-git \
ttf-font-awesome \
ttf-material-design-icons \
polybar 



#sed -i '$ a if [[ -z $DISPLAY ]] && [[ $(tty) = /dev/tty1 ]]; then' ~/.bash_profile
#sed -i '$ a startx' ~/.bash_profile
#sed -i '$ a fi' ~/.bash_profile



cat > ~/.xinitrc <<EOF
exec exec bspwm
EOF

sudo systemctl enable bluetooth.service

mkdir ~/.config
mkdir ~/.config/bspwn
mikdir ~/.config/sxhd
sudo install -Dm755 /usr/share/doc/bspwm/examples/bspwmrc ~/.config/bspwm/bspwmrc
sudo install -Dm644 /usr/share/doc/bspwm/examples/sxhkdrc ~/.config/sxhkd/sxhkdrc


sudo pacman -Rsn --noconfirm  $(pacman -Qdtq)



