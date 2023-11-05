PW=1234
User=timon

#time, language, hostname, hosts 
ln -s /usr/share/zoneinfo/Europe/Berlin /etc/localtime
echo "de_DE.UTF-8 UTF-8" >> /etc/local.gen
locale-gen
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
refind-install --usedefault /dev/nvme0n1p1 --alldrivers
mkrlconf
echo '"Boot with minimal options"   "ro root=/dev/nvme0n1p3"' > /boot/refind_linux.conf
cp ./refind.conf /boot/EFI/BOOT/refind.conf

mkdir /boot/EFI/BOOT/themes
cp ./files/refind.conf /boot/EFI/BOOT/refind.conf
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
pacman -Syu
#fonts + themes
pacman -Sy ttf-liberation ttf-font-awesome ttf-fira-sans ttf-fira-code ttf-firacode-nerd breeze breeze-gtk chili-sddm-theme papirus-icon-theme
#driver
pacman -Sy amdvlk lib32-amdvlk gnome-keyring pipewire pulseaudio-bluetooth
#hyprland
pacman -Sy xdg-desktop-portal-hyprland hyprland sddm dunst waybar polkit-kde-agent qt5-wayland qt6-wayland cliphist wlogout
#comand line applications
pacman -Sy reflector grim slurp nano flatpak python git bpytop firewalld ipset ebtables neofetch xautolock swayidle
#gui
pacman -Sy steam alacritty lutris gnome-boxes kdeconnect sxiv mpv vlc xfce4-power-manager thunar lxappearance pavucontrol blueman swappy

#Bluetooth
systemctl enable bluetooth

#firewall
systemctl enable firewalld
firewall-cmd --set-default-zone=home

#set fastes mirror
pacman -S reflector
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
cp ./files/sddm.conf /etc/sddm.conf

flatpak install flathub com.jetbrains.PyCharm-Community org.mozilla.firefox org.chromium.Chromium com.visualstudio.code \
                        com.github.tchx84.Flatseal com.discordapp.Discord org.libreoffice.LibreOffice \
                        com.getmailspring.Mailspring com.github.sdv43.whaler io.github.hakuneko.HakuNeko \
                        com.mojang.Minecraft \

sudo -u $User yay -S swww swaylock-effects goverlay timeshift rofi-wayland archlinux-tweak-tool-git bibata-cursor-theme

###############################
############dotfiles###########
###############################



set_config(){
    sudo -u $User mkdir $1 
    sudo -u $User copy $2 "$1/$2"
}

set_config "~" "./files/bashrc" ".bashrc"
set_config "~/.config" "./files/alacitty.yml" "alacitty.yml"
set_config "~/.config" "./files/dunstrc" "dunstrc"
set_config "~" "./files/gtk/gtkrc-2.0" ".gtkrc-2.0"
set_config "~/.config/gtk-3.0" "./files/gtk/gtk-3.0" "settings.ini"
set_config "~/.config/gtk-4.0" "./files/gtk/gtk-4.0" "settings.ini"
set_config "~/.config/gtk" "./files/gtk/gtk.sh" "gtk.sh"
set_config "~/.config/swaylock" "./files/swaylock" "config"
set_config "~/.config/swappy" "./files/swappy" "config"
set_config "~/.config/waybar" "./files/waybar/config" "config"
set_config "~/.config/waybar" "./files/waybar/style.css" "style.css"
set_config "~/.config/hypr" "./files/hyprland.conf" "hyprland.conf"
sudo -u $User cp -r ./background ~/.config/background
sudo -u $User cp -r ./files/scripts ~/.cofing/scripts
sudo -u $User cp -r ./files/rofi ~/.cofing/rofi


