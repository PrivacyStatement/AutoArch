####################
####IMPORT FILES####
####################
source /home/AutoArch/scripts/func_vars.sh
source /home/AutoArch/settings.sh

####################
####CATCH ERRORS####
####################
trap 'handle_error $LINENO' ERR

####################
###NETWORK CHECK####
####################
ERROR_CODE="No Network Connection!"
ping -c 1 "1.1.1.1" 
success "Network Connected"

####################
CHAPTER "Set System Settings"
####################
ERROR_CODE="Setting Timezone has failed"
ln -s /usr/share/zoneinfo/$timezone_set /etc/localtime
ERROR_CODE="Setting locale has failed"
echo "$local_set UTF-8" >> /etc/local.gen
locale-gen
ERROR_CODE="Setting language has failed"
echo LANG=$local_set >> /etc/locale.conf
ERROR_CODE="Setting keymap has failed"
echo KEYMAP=$keymap_set >> /etc/vconsole.conf
ERROR_CODE="Setting hostname has failed"
echo arch"$User" >> /etc/hostname
ERROR_CODE="Setting hostsfile has failed"
echo "127.0.0.1	localhost" >> /etc/hosts
echo "::1		localhost" >> /etc/hosts
echo "127.0.1.1	arch"$User".localdomain	arch" >> /etc/hosts
success "System Settings are set."

####################
CHAPTER "Add User"
####################
ERROR_CODE="Set wheel group to sudoers has failed"
echo "%wheel      ALL=(ALL:ALL) ALL" >> /etc/sudoers
echo "root ALL=($user) NOPASSWD: ALL" >> /etc/sudoers
ERROR_CODE="Changing root password has failed"
echo root:$root_PW | chpasswd
ERROR_CODE="Adding New User has failed"
useradd -m $User
ERROR_CODE="Setting password for new user has failed"
echo $User:$PW | chpasswd
ERROR_CODE="Adding groupes to new user has failed"
usermod -aG wheel,audio,video,optical,storage $User
success "User $name added and Password changed"

####################
CHAPTER "Bootloader configuration"
####################
ERROR_CODE="Setting up bootloader has failed"
refind-install --usedefault "/dev/disk/by-label/ARCH_BOOT" --alldrivers
mkrlconf
ERROR_CODE="Configuring bootloader has failed"
Patition_ROOT=$(realpath '/dev/disk/by-label/ARCH-HOME')
echo "\"Boot with minimal options\"   \"ro root=${Patition_ROOT}\"" > /boot/refind_linux.conf
cp /home/AutoArch/files/refind.conf /boot/EFI/BOOT/refind.conf

ERROR_CODE="Loading Bootloader themes has failed"
mkdir /boot/EFI/BOOT/themes
wget https://github.com/evanpurkhiser/rEFInd-minimal/archive/refs/heads/main.zip
unzip main.zip -d /boot/EFI/BOOT/themes
mv /boot/EFI/BOOT/themes/rEFInd-minimal-main /boot/EFI/BOOT/themes/rEFInd-minimal
rm main.zip
success "Refind bootloader installed"

####################
CHAPTER "Mount External Folder"
####################
ERROR_CODE="Mount External Folder has failed"
#mkdir /home/$User/game
#mount /dev/sdb2 /home/$User/game
success "Extra Folder mounted"

####################
CHAPTER "pacman config"
####################
ERROR_CODE="Changing pacman config has failed"
sed -i 's/#\[multilib\]/\[multilib\]\nInclude = \/etc\/pacman.d\/mirrorlist/' /etc/pacman.conf
sed -i 's/#ParallelDownloads = 5/ParallelDownloads = 5/' /etc/pacman.conf

####################
CHAPTER "update and install"
####################
ERROR_CODE="Installing pacman software has failed"
source  /home/AutoArch/scripts/install_pacman.sh
success "Installing software"

####################
CHAPTER "Enable systemctl service"
####################
#Network
ERROR_CODE="Enable NetworkManager has failed"
systemctl enable NetworkManager
#Bluetooth
ERROR_CODE="Enable bluetooth has failed"
systemctl enable bluetooth
#firewall
ERROR_CODE="Enable firewalld has failed"
systemctl enable firewalld
#sddm
ERROR_CODE="Enable sddm has failed"
systemctl enable sddm
success "Enable systemctl services"

####################
CHAPTER "Set fastes mirror"
####################
ERROR_CODE="Finding fastes mirror has failed"
reflector --country "$mirror_country" --latest 50 --protocol https --sort rate --save /etc/pacman.d/mirrorlist
success "Fastest mirreor set for $mirror_country"

####################
CHAPTER "Installing YAY"
####################
ERROR_CODE="Creating folder for YAY install has failed"
mkdir /AUR
cd /AUR
ERROR_CODE="Clone YAY from git has failed"
git clone https://aur.archlinux.org/yay-git.git
chmod 777 ./yay-git
cd ./yay-git
ERROR_CODE="Installing YAY in user contexted has failed"
sudo -u $User makepkg -sic $confirm
ERROR_CODE="Removing folder for YAY install has failed"
cd /
rm -r /AUR
success "Yay installed"

####################
CHAPTER "Installing AUR Packages"
####################
ERROR_CODE="Installing AUR Packages has failed"
sudo -u $User yay -S $confirm swww swaylock-effects goverlay timeshift rofi-lbonn-wayland archlinux-tweak-tool-git bibata-cursor-theme wlogout chili-sddm-theme
success "AUR packages installed"

flatpak install -y flathub com.jetbrains.PyCharm-Community org.mozilla.firefox org.chromium.Chromium com.visualstudio.code \
                        com.github.tchx84.Flatseal com.discordapp.Discord org.libreoffice.LibreOffice \
                        com.getmailspring.Mailspring com.github.sdv43.whaler io.github.hakuneko.HakuNeko \
                        com.mojang.Minecraft \


#remove sudo -u user rights
ERROR_CODE="Removing root acces to $user has failed"
sudo sed -i 's/root ALL=($user) NOPASSWD: ALL//' /etc/sudoers

####################
CHAPTER "Setting Dotfiles"
####################
ERROR_CODE="Dotfiles copying has failed"
cp /home/AutoArch/files/sddm.conf /etc/sddm.conf
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
success "Dotfiles set"
