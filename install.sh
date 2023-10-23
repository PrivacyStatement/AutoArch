PW=1234

pacman -Syu
pacman -Sy refind ntfs-3g unzip wget networkmanager

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
echo "%wheel      ALL=(ALL:ALL) ALL" >> /etc/sudoers
echo root:$PW | chpasswd 
useradd -m timon
echo timon:$PW | chpasswd
usermod -aG wheel,audio,video,optical,storage timon

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
mkdir /home/timon/game
mount /dev/sdb2 /home/timon/game

#Start Network after reboot
systemctl enable NetworkManager
