#Bluetooth
systemctl enable bluetooth --now

#firewall
systemctl enable firewalld --now
firewall-cmd --set-default-zone=home

#pacman config
sed -i 's/#\[multilib\]/\[multilib\]\nInclude = \/etc\/pacman.d\/mirrorlist/' /etc/pacman.conf
sed -i 's/#ParallelDownloads = 5/ParallelDownloads = 5/' /etc/pacman.conf

#install and update
pacman -Syu
pacman -Sy sddm
#fonts
pacman -Sy ttf-liberation ttf-font-awesome ttf-fira-sans ttf-fira-code ttf-firacode-nerd
#hyprland
pacman -Sy hyprland dunst xdg-desktop-portal-hyprland polkit-kde-agent

pacman -Sy  jack2 amdvlk lib32-amdvlk
pacman -Sy nano steam alacritty grim reflector ntfs-3g unzip wget networkmanager 
pacman -Sy pulseaudio-bluetooth flatpak steam lutris gnome-boxes kdeconnect python git bpytop firewalld ipset ebtables neofetch 



#set fastes mirror
pacman -S reflector
reflector -c Germany --sort rate -l 50 --save /etc/pacman.d/mirrorlist 

#install yay
mkdir ~/AUR
cd ~/AUR
git clone https://aur.archlinux.org/yay-git.git
cd ~/AUR/yay-git
makepkg -sic

#sddm
systemctl enable sddm
yay -S chili-sddm-theme
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

yay -S goverlay timeshift rofi-wayland archlinux-tweak-tool-git lxpolkit
#Image viewer & Video player
pacman -Sy sxiv mpv vlc
#Background
pacman -Sy nitrogen
#Power Managment + ScreenLock
pacman -Sy xfce4-power-manager xautolock
#FileManager     | ThemeSwitcher + Themes
pacman -Sy thunar lxappearance breeze breeze-gtk

pacman -Sy pipewire pulseaudio-bluetooth

#TopBar + AudioControl + BluethothControl
pacman -Sy waybar pavucontrol blueman 

pacman -Sy gnome-keyring

#dotfiles
