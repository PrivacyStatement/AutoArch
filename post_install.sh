firewall-cmd --set-default-zone=home

#install timeshift + goverlay vieleicht yay
mkdir ~/AUR
cd ~/AUR
git clone https://aur.archlinux.org/yay-git.git
cd ~/AUR/yay-git
makepkg -sic

yay -S goverlay
yay -S timeshift
yay -S rofi-wayland
yay -S archlinux-tweak-tool-git

#sddm
yay -S chili-sddm-theme
#set theme

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
