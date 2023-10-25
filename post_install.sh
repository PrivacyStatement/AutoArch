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
systemctl enable firewalld --now
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
sudo -u timon makepkg -sic
cd ../..
rm -r ~/AUR

#sddm
systemctl enable sddm
cp ./files/sddm.conf /etc/sddm.conf

flatpak install flathub com.jetbrains.PyCharm-Community org.mozilla.firefox org.chromium.Chromium com.visualstudio.code \
                        com.github.tchx84.Flatseal com.discordapp.Discord org.libreoffice.LibreOffice \
                        com.getmailspring.Mailspring com.github.sdv43.whaler io.github.hakuneko.HakuNeko \
                        com.mojang.Minecraft \

sudo -u timon yay -S swww swaylock-effects goverlay timeshift rofi-wayland archlinux-tweak-tool-git bibata-cursor-theme

###############################
############dotfiles###########
###############################



set_config(){
    sudo -u timon mkdir $1 
    sudo -u timon copy $2 "$1/$2"
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
sudo -u timon cp -r ./background ~/.config/background
sudo -u timon cp -r ./files/scripts ~/.cofing/scripts
sudo -u timon cp -r ./files/rofi ~/.cofing/rofi

