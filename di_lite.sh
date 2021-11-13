user=$(whoami)

echo -e "\e[31m-----------------\e[0m"
echo -e "\e[31mBS Arch Install Script\e[0m"
echo -e "\e[31m----------------\e[0m"

echo -e "\e[35m-----------------\e[0m"
echo -e "\e[35mBase DTE installing ...... \e[35m"




sudo pacman -Sy
sudo pacman -S --noconfirm \
htop \
thunar-volman \
udisks2 \
gvfs \
ntfs-3g \
xorg-server \
xorg-xinit \
dmenu \
p7zip \
gvfs-smb \
sshfs \
firefox \
fakeroot \
minizip \
go \
base-devel \
lximage-qt \
lxqt-about \
lxqt-admin \
lxqt-archiver \
lxqt-config \
lxqt-globalkeys \
lxqt-openssh-askpass \
lxqt-panel \
lxqt-policykit \
lxqt-powermanagement \
lxqt-qtplugin \
lxqt-runner \
lxqt-session \
lxqt-themes \
pavucontrol-qt \
pcmanfm-qt \
flameshot \
openbox \
obconf-qt \
notepadqq \
#signal-desktop



#yay install
git clone https://aur.archlinux.org/yay.git
chown $user:$user ./yay
cd yay
makepkg -si
cd ..
rm -r -f ./yay/

sed -i '$ a if [[ -z $DISPLAY ]] && [[ $(tty) = /dev/tty1 ]]; then' ~/.bash_profile
sed -i '$ startx' ~/.bash_profile
sed -i '$ a fi' ~/.bash_profile



sudo pacman -Rsn --noconfirm  $(pacman -Qdtq)



