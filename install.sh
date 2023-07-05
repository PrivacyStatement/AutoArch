

#stelle linux auf Deutsch
echo LANG=de_DE.UTF-8 > /etc/locale.conf
echo KEYMAP=de-latin1-nodeadkeys > /etc/vconsole.conf
ln -s /usr/share/zoneinfo/Europe/Berlin /etc/localtime

#aktivire DHCP für Netzwerk
systemctl enable dhcpcd

#Update das System
sudo pacman -Syu

#Treiber für AMD und Desktop
pacman -S xf89-video-amd plasma plasma-wayland-session

#Aktivire SDDM
systemctl enable sddm.service

#mount windows drive
mkdir /home/timon/game
lsblk -nr -o UUID,NAME | grep nvme0n1p2 | grep -Po '.* '
sed 's/{uuid1}/hallo/g' ./files/fstab_add | sed 's/{uuid2}/hallo2/g' > /etc/fstab
findmnt --verify
systemctl daemon-reload

#installiere Applikationen
pacman -S firefox
