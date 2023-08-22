PW=1234

#stelle linux auf Deutsch
echo de_DE.UTF-8 >> /etc/locale.gen
locale-gen
echo LANG=de_DE.UTF-8 > /etc/locale.conf
echo KEYMAP=de-latin1-nodeadkeys > /etc/vconsole.conf
ln -s /usr/share/zoneinfo/Europe/Berlin /etc/localtime

#set hostname
echo archtimon > /etc/hostname

#add user
echo root:$PW | chpasswd 
useradd -m timon
echo timon:$PW | chpasswd
usermod -aG sudo,wheel,audio,video,optical,storage timon

#REFIND Bootloader
pacman -S refind
refind-install --usedefault /dev/nvme0n1p1 --alldriver
mkrlconf
# refind_linux.conf = "Boot with minimal options"   "ro root=/dev/nvme0n1p3"


#aktivire DHCP für Netzwerk
pacman -S networkmanager
systemctl enable NetworkManager
#systemctl enable dhcpcd

#Update das System
pacman -Syu

#set fastes mirror
pacman -S reflector
reflector -c Germany --sort rate -l 50 --save /etc/pacman.d/mirrorlist 



#Treiber für AMD und Desktop
#pacman -S xf89-video-amd plasma plasma-wayland-session
#Aktivire SDDM
#systemctl enable sddm.service

#make game folder
mkdir /home/timon/game

#theme rEFInd
pacman -S unzip
mkdir /boot/EFI/BOOT/themes
cp ./files/refind.conf /boot/EFI/BOOT/refind.conf
wget https://github.com/evanpurkhiser/rEFInd-minimal/archive/refs/heads/main.zip
unzip main.zip -d /boot/EFI/BOOT/themes
rm main.zip

#Bluetooth
sudo pacman -S pulseaudio-bluetooth
sudo systemctl enable bluetooth

#firewall
pacman -S firewalld ipset ebtables
systemctl enable --now firewalld
firewall-cmd --set-default-zone=home
#for kdm vms set
#firewall-cmd --add-service libvirt --zone=linbvirt --permanen

#installiere Applikationen
pacman -S neofetch
pacman -Sy ttf-liberation

#set multilib enabled in /ect/pacman.conf
pacman -S flatpak steam lutris gnome-boxes kdeconnect python git alacritty bpytop

#install timeshift + goverlay vieleicht yay
mkdir ~/AUR
cd ~/AUR
git clone https://aur.archlinux.org/yay-git.git
cd ~/AUR/yay-git
makepkg -sic

yay -S goverlay.git
yay -S timeshift.git

#hyperland
pacman -S hyprland
yay -S rofi-wayland

#hyperland screenshots
pacman -S grim

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
