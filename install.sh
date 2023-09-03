PW=1234

#pacman config
sed -i 's/#\[multilib\]/\[multilib\]\nInclude = \/etc\/pacman.d\/mirrorlist/' /ect/pacman.conf
sed -i 's/#ParallelDownloads = 5/ParallelDownloads = 5/' /ect/pacman.conf

#install and update
pacman -Syu
pacman -Sy xdg-desktop-portal-hyprland jack2 ttf-liberation amdvlk lib32-amdvlk
pacman -Sy nano steam alacritty grim reflector ntfs-3g unzip wget networkmanager pulseaudio-bluetooth flatpak steam lutris gnome-boxes kdeconnect python git bpytop firewalld ipset ebtables neofetch refind
pacman -S hyprland

#time, language, hostname, hosts 
ln -s /usr/share/zoneinfo/Europe/Berlin /etc/localtime
echo "de_DE.UTF-8 UTF-8" >> /etc/local.gen
locale-gen
echo LANG=de_DE.UTF-8 >> /etc/locale.conf
echo KEYMAP=de-latin1-nodeadkeys >> /etc/vconsole.conf
echo archtimon >> /etc/hostname
echo "127.0.0.1	localhost" >> /etc/hosts
echo "::1		localhost" >> /etc/hosts
echo "127.0.1.1	archtimon.localdomain	arch" >> /etc/hosts

#add user
echo root:$PW | chpasswd 
useradd -m timon
echo timon:$PW | chpasswd
usermod -aG wheel,audio,video,optical,storage timon

#Bootloader config
refind-install --usedefault /dev/nvme0n1p1 --alldriver
mkrlconf
echo 'refind_linux.conf = "Boot with minimal options"   "ro root=/dev/nvme0n1p3"' > /boot/refind_linux.conf
cp ./refind.conf /boot/EFI/BOOT/refind.conf

mkdir /boot/EFI/BOOT/themes
cp ./files/refind.conf /boot/EFI/BOOT/refind.conf
wget https://github.com/evanpurkhiser/rEFInd-minimal/archive/refs/heads/main.zip
unzip main.zip -d /boot/EFI/BOOT/themes
rm main.zip

#make game folder
mkdir /home/timon/game
mount /dev/sdb2 /home/timon/game

#set fastes mirror
pacman -S reflector
reflector -c Germany --sort rate -l 50 --save /etc/pacman.d/mirrorlist 

#Start Network after reboot
systemctl enable NetworkManager

#Bluetooth
systemctl enable bluetooth

#firewall
systemctl enable --now firewalld
