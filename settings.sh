####################
#####PRODUCTION#####
####################
: '
lang="de-latin1"
disk="nvme0n1"
disk_part="p"
swap="10G"
root="50G"
debug=true
User=timon
PW=1234
Patition_BOOT=nvme0n1p1
Patition_ROOT=nvme0n1p3

#install default
steam_font=ttf-liberation
hyprland_portal=xdg-desktop-portal-hyprland
'

####################
########TEST########
####################
lang="de-latin1"
disk="sda"
disk_part=""
swap="1G"
root="10G"
debug=true
User=timon
PW=1234
Patition_BOOT=nvme0n1p1
Patition_ROOT=nvme0n1p3

#install default
steam_font=ttf-liberation
hyprland_portal=xdg-desktop-portal-hyprland
