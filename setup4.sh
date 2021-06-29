user=$(whoami)

echo -e "\e[31m-----------------\e[0m"
echo -e "\e[31mBS Arch Install Script\e[0m"
echo -e "\e[31m----------------\e[0m"


echo -e "\e[35m-----------------\e[0m"
echo -e "\e[35mNSoftware due to be installed\e[35m


#notes 
#amd-ucode - AMD Ryzen microcode
#need to do post create of 


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
nvidia - Nvidia drivers 
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





sudo pacman -S --noconfirm \
networkmanager \
pavucontrol \
pulseaudio \
alsa \
pulseaudio-alsa \
openconnect \
nano \
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
nvidia \
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
freerdp


echo -e "\e[35m-----------------\e[0m"
echo -e "\e[31m-----------------\e[0m"
echo -e "\e[31mEnable Services\e[0m"
echo -e "\e[31m-----------------\e[0m"
echo Setting up base services
sudo systemctl enable NetworkManager



#yay install
git clone https://aur.archlinux.org/yay.git
chown $user:$user ./yay
cd yay
makepkg -si
cd ..
rm -r -f ./yay/

#install yay packages
yay -S \
teams \
dropbox \
powershell-bin \
signal-desktop \
teamviewer \

echo -e "\e[31m-----------------\e[0m"
echo -e "\e[31mSetup of system files\e[0m"
echo -e "\e[31m-----------------\e[0m"


.






