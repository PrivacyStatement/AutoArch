

//stelle linux auf Deutsch
echo LANG=de_DE.UTF-8 > /etc/locale.conf
echo KEYMAP=de-latin1-nodeadkeys > /etc/vconsole.conf
ln -s /usr/share/zoneinfo/Europe/Berlin /etc/localtime

//aktivire DHCP für Netzwerk
systemctl enable dhcpcd

//Update das System
sudo pacman -Syu

//Treiber für AMD und Desktop
pacman -S xf89-video-amd plasma plasma-wayland-session

//Aktivire SDDM
systemctl enable sddm.service

//installiere Applikationen
pacman -S firefox
