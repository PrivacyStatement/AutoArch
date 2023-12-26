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
root_PW=1234
Patition_BOOT=nvme0n1p1
Patition_ROOT=nvme0n1p3
confirm=--noconfirm
'

#File from /usr/share/zoneinfo/
timezone_set="Europe/Berlin"
local_set="de_DE.UTF-8"
keymap_set="de-latin1-nodeadkeys"

mirror_country="Germany"
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
root_PW=1234
confirm=""

#install default
vulcan_driver="vulkan-radeon"
lib32_vulkan_driver="lib32-vulkan-radeon"
