user=$(whoami)
# change default shell to zsh 
echo -e "\e[32m  To set ZSH as default shell enter password for:  =  \e""[0m \e[31m"$newuname"\e[0m"
chsh -s "$(which zsh)"

echo -e "\e[31m-----------------\e[0m"
echo -e "\e[31mBS Arch Install Script\e[0m"
echo -e "\e[31m----------------\e[0m"

echo -e "\e[35mEnter password for "$user" to change shell to zsh d\e[35m"
chsh -s $(which zsh)

echo -e "\e[35m-----------------\e[0m"
echo -e "\e[35mNSoftware due to be installed\e[35m



core system components :-
network-manager - Network configuration
pavucontrol - sound controller
pulseaudio - sound contoller
alsa - sound controller
pulseaudio-alsa - pulse audio controller for alsa 
openconnect - vpn tool
grub - boot loader
efibootmgr - efi boot manager
amd-ucode - amdi microcode
sudo - sudo user control
fakeroot - required for yay 


Terminal tools :-
nano - text editor
nmap - network scan tool
htop - System resources tool
git - Github downloader
wget - web downloader
net-tools - network toolkit

Disk tools :-
gparted - GUI partition tool
thunar-volman - XFCE4 volume manager
udisks2 - disk auto mounting 
gvfs - disk auto mounting 
ntfs-3g allow mounting of windows ntfs drives

Desktop windows manager :-
xfce4 - Core desktop manager
lightdm - Login screen
lightdm-gtk-greeter - login screen theme
xorg-server - Core level graphical interface
dmenu - desktop quick run tool
network-manager-applet - network system tray applet
xfce4-screensaver - screensavers
xfce4-pulseaudio-plugin - Sound control
xfce4-screenshooter - screenshot tool
obs-studio - screen recorder / broadcaster
thunar-archive-plugin - thunar archive file manager 
xarchiver - required for extracting zip etc
p7zip - required for extracting 7zip files
lm_sensors - system temps
xsensors - gui for lm_sensors
xpdf - pdf viewer
gvfs-smb - browse smb shares
sshfs - browse ssh
teams YAY - MS Teams
dropbox YAY - dropbox client
powershell-bin YAY - MS powershell
signal-desktop YAYT - signal messagner
teamviewer YAY - teamviewer client


Desktop tools :-
firefox - Web browser
virtualbox - VM Enviroment
vlc - media player
notepadqq - notepad ++ for linux
libreoffice-fresh - office program
gimp - video editing


Gaming! :-
steam - well its steam! 
ttf-liberation - font set used by steam 

Remote connection software :-
remmina - remote connection gui
freerdp - remmina's rdp plugin
[0m"




sudo pacman -Sy
sudo pacman -S --noconfirm \
pavucontrol \
pulseaudio \
alsa \
pulseaudio-alsa \
openconnect \
nmap \
htop \
git \
wget \
net-tools \
gparted \
thunar-volman \
udisks2 \
gvfs \
ntfs-3g \
xfce4 \
lightdm \
lightdm-gtk-greeter \
xorg-server \
dmenu \
network-manager-applet \
xfce4-screensaver \
xfce4-pulseaudio-plugin \
xfce4-screenshooter \
obs-studio \
thunar-archive-plugin \
xarchiver \
p7zip \
lm_sensors \
xsensors \
xpdf \
gvfs-smb \
sshfs \
firefox \
virtualbox \
vlc \
notepadqq \
libreoffice-fresh \
gimp \
steam \
ttf-liberation \
remmina \
freerdp \
fakeroot \
minizip \
bluez \
bluez-utils \
blueman \
pulseaudio-bluetooth \


#copy xfce4 base settings

sudo cp -rf xfce4 /etc/xdg/
sudo cp -rf autostart /etc/xda/

echo -e "\e[35m-----------------\e[0m"
echo -e "\e[31m-----------------\e[0m"
echo -e "\e[31mEnable Services\e[0m"
echo -e "\e[31m-----------------\e[0m"
echo Setting up base services
sudo systemctl enable NetworkManager
sudo systemctl enable lightdm.service

wget https://linux.dropbox.com/fedora/rpm-public-key.asc
gpg --import rpm-public-key.asc


#yay install
git clone https://aur.archlinux.org/yay.git
chown $user:$user ./yay
cd yay
makepkg -si
cd ..
rm -r -f ./yay/

#install yay packages
yay -S --nodiffmenu --noeditmenu --removemake --cleanafter --rebuildall --nocleanmenu --noconfirm --removemake --rebuild --useask --nobatchinstall \
teams \
dropbox \
powershell-bin \
signal-desktop \
teamviewer 

yay --clean --noconfirm

sudo systemctl enable teamviewerd.service

sudo pacman -S --noconfirm xfce4

sudo pacman -Rsn --noconfirm  $(pacman -Qdtq)
reboot 

