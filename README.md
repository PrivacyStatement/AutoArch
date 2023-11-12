Dotfiles from https://gitlab.com/stephan-raabe/dotfiles/-/tree/main?ref_type=heads

RUN:
1. pacman -Sy wget unzip
2. wget https://github.com/PrivacyStatement/AutoArch/archive/main.zip
3. unzip main.zip
4. chmod 700 ./AutoArch/preinstall.sh
5. ./AutoArch/preinstall.sh | tee /mnt/install.log

ERRORs:
yay needs confirm and PW
onFirstStart needs AutoStart
hyprland dosnt work
sddm theme dosnt work
Bluetooth isn´t in autostart

flatpak and firewall are questional

ther are a lot more problems but this are the first to fix
