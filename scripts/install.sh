source ./scripts/func_vars.sh
source ./settings.sh

if [ !debug ]; then
confirm=--noconfirm
else
confirm=""
fi

figlet "Set System Settings"
#time, language, hostname, hosts
trap "wait_input 'Systemsettings set Setting' 'locale has failed'" ERR
ln -s /usr/share/zoneinfo/Europe/Berlin /etc/localtime
wait_input "Timezone set" "Setting timezone has failed"
echo "de_DE.UTF-8 UTF-8" >> /etc/local.gen
locale-gen
wait_input "locale set" "Setting locale has failed"
echo LANG=de_DE.UTF-8 >> /etc/locale.conf
echo KEYMAP=de-latin1-nodeadkeys >> /etc/vconsole.conf
echo arch"$User" >> /etc/hostname
echo "127.0.0.1	localhost" >> /etc/hosts
echo "::1		localhost" >> /etc/hosts
echo "127.0.1.1	arch"$User".localdomain	arch" >> /etc/hosts

#add user
echo "%wheel      ALL=(ALL:ALL) ALL" >> /etc/sudoers
echo root:$PW | chpasswd 
useradd -m $User
echo $User:$PW | chpasswd
usermod -aG wheel,audio,video,optical,storage $User

#Bootloader config
refind-install --usedefault "/dev/${Patition_BOOT}" --alldrivers
mkrlconf
echo "\"Boot with minimal options\"   \"ro root=/dev/${Patition_ROOT}\"" > /boot/refind_linux.conf
cp /home/AutoArch/refind.conf /boot/EFI/BOOT/refind.conf

mkdir /boot/EFI/BOOT/themes
wget https://github.com/evanpurkhiser/rEFInd-minimal/archive/refs/heads/main.zip
unzip main.zip -d /boot/EFI/BOOT/themes
mv /boot/EFI/BOOT/themes/rEFInd-minimal-main /boot/EFI/BOOT/themes/rEFInd-minimal
rm main.zip

#make game folder
mkdir /home/$User/game
mount /dev/sdb2 /home/$User/game

#Start Network after reboot
systemctl enable NetworkManager

#pacman config
sed -i 's/#\[multilib\]/\[multilib\]\nInclude = \/etc\/pacman.d\/mirrorlist/' /etc/pacman.conf
sed -i 's/#ParallelDownloads = 5/ParallelDownloads = 5/' /etc/pacman.conf

#install and update
pacman -Syu $confirm
#fonts + themes
pacman -Sy $confirm ttf-liberation ttf-font-awesome ttf-fira-sans ttf-fira-code ttf-firacode-nerd breeze breeze-gtk chili-sddm-theme papirus-icon-theme
#driver
pacman -Sy $confirm gnome-keyring pipewire pipewire-jack pipewire-media-session pulseaudio-bluetooth
#hyprland
pacman -Sy $confirm xdg-desktop-portal-hyprland hyprland dunst waybar polkit-kde-agent qt5-wayland qt6-wayland cliphist wlogout
#comand line applications
pacman -Sy $confirm $hyprland_portal reflector grim slurp nano flatpak python git bpytop firewalld ipset ebtables neofetch xautolock swayidle
#gui
pacman -Sy $confirm $steam_font steam alacritty lutris gnome-boxes kdeconnect sxiv mpv vlc xfce4-power-manager thunar lxappearance pavucontrol blueman swappy

#Bluetooth
systemctl enable bluetooth

#firewall
systemctl enable firewalld

#set fastes mirror
reflector -c Germany --sort rate -l 50 --save /etc/pacman.d/mirrorlist 

#install yay
mkdir ./AUR
cd ./AUR
git clone https://aur.archlinux.org/yay-git.git
chmod 777 ./yay-git
cd ./yay-git
sudo -u $User makepkg -sic
cd ../..
rm -r ~/AUR

#sddm
systemctl enable sddm
cp /home/AutoArch/files/sddm.conf /etc/sddm.conf

sudo -u $User yay -S swww swaylock-effects goverlay timeshift rofi-lbonn-wayland archlinux-tweak-tool-git bibata-cursor-theme

###############################
############dotfiles###########
###############################

set_config "" ".bashrc" "bashrc"
set_config ".config" "alacitty.yml" "alacitty.yml"
set_config ".config" "dunstrc" "dunstrc"
set_config "" ".gtkrc-2.0" "gtk/gtkrc-2.0"
set_config ".config/gtk-3.0" "settings.ini" "gtk/gtk.3.0"
set_config ".config/gtk-4.0" "settings.ini" "gtk/gtk.4.0"
set_config ".config/gtk" "gtk.sh" "gtk/gtk.sh"
set_config ".config/swaylock" "config" "swaylock"
set_config ".config/swappy" "config" "swappy"
set_config ".config/waybar" "config" "waybar/config"
set_config ".config/waybar" "style.css" "waybar/style.css"
set_config ".config/hypr" "hyprland.conf" "hyprland.conf"
set_config ".config" "background" "../background"
set_config ".config" "scripts" "scripts"
set_config ".config" "rofi" "rofi"



