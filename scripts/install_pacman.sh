pacman -Syu $confirm
sed -i 's/#\[multilib\]/\[multilib\]\nInclude = \/etc\/pacman.d\/mirrorlist/' /etc/pacman.conf
sed -i 's/#ParallelDownloads = 5/ParallelDownloads = 5/' /etc/pacman.conf

#fonts + themes
pacman -Sy $confirm $vulcan_driver $lib32_vulkan_driver ttf-liberation ttf-font-awesome ttf-fira-sans ttf-fira-code ttf-firacode-nerd breeze breeze-gtk papirus-icon-theme gnome-keyring pipewire pipewire-jack pipewire-media-session pulseaudio-bluetooth xdg-desktop-portal-hyprland hyprland dunst waybar polkit-kde-agent qt5-wayland qt6-wayland cliphist  xdg-desktop-portal-hyprland reflector grim slurp nano flatpak python git bpytop firewalld ipset ebtables neofetch xautolock swayidle ttf-liberation steam alacritty lutris gnome-boxes kdeconnect sxiv mpv vlc xfce4-power-manager thunar lxappearance pavucontrol blueman swappy
