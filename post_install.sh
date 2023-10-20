#Bluetooth
systemctl enable bluetooth --now

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
pacman -Sy hyprland sddm dunst waybar xdg-desktop-portal-hyprland polkit-kde-agent qt5-wayland qt6-wayland cliphist wlogout
#comand line applications
pacman -Sy reflector grim slurp nano flatpak python git bpytop  firewalld ipset ebtables neofetch xautolock swayidle
#gui
pacman -Sy steam alacritty lutris gnome-boxes kdeconnect sxiv mpv vlc xfce4-power-manager thunar lxappearance pavucontrol blueman swappy
 
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
cd ./yay-git
makepkg -sic
cd ../..
rm -r ~/AUR

#sddm
systemctl enable sddm
cp ./files/sddm.conf /etc/sddm.conf

flatpak install flathub com.jetbrains.PyCharm-Community
flatpak install flathub org.mozilla.firefox
flatpak install flathub org.chromium.Chromium
flatpak install flathub com.visualstudio.code
flatpak install flathub com.github.tchx84.Flatseal
flatpak install flathub com.discordapp.Discord
flatpak install flathub org.libreoffice.LibreOffice
flatpak install flathub com.getmailspring.Mailspring
flatpak install flathub com.github.sdv43.whaler
flatpak install flathub io.github.hakuneko.HakuNeko
flatpak install flathub com.mojang.Minecraft

yay -S swww swaylock-effects goverlay timeshift rofi-wayland archlinux-tweak-tool-git bibata-cursor-theme

###############################
############dotfiles###########
###############################

cp ./files/bashrc ~/.bashrc
cp ./files/alacitty.yml ~/.config/alacitty.yml
cp ./files/dunstrc ~/.config/dunstrc
cp ./files/gtk/gtkrc-2.0 ~/.gtkrc-2.0
cp ./files/gtk/gtk-3.0 ~/.config/gtk-3.0/settings.ini
cp ./files/gtk/gtk-4.0 ~/.config/gtk-4.0/settings.ini
cp ./files/gtk/gtk.sh ~/.config/gtk/gtk.sh
cp ./files/swaylock ~/.config/swaylock/config
cp ./files/swappy ~/.config/swappy/config
cp -r ./background ~/.config/background
cp ./files/waybar/config ~/.config/waybar/config
cp ./files/waybar/style.css ~/.config/waybar/style.css
cp -r ./files/scripts ~/.cofing/scripts
cp -r ./files/rofi ~/.cofing/rofi
cp ./files/hyprland.conf ~/.config/hypr/hyprland.conf
