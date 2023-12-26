timezone_set="Europe/Berlin"
local_set="de_DE.UTF-8"
keymap_set="de-latin1-nodeadkeys"
mirror_country="Germany"
lang="de-latin1"
debug=false
#install default
vulcan_driver="vulkan-radeon"
lib32_vulkan_driver="lib32-vulkan-radeon"

####################
#####PRODUCTION#####
####################
: '
disk="nvme0n1"
disk_part="p"
swap="10G"
root="50G"
User=timon
PW=1234
root_PW=1234
confirm=
'

####################
########TEST########
####################
disk="sda"
disk_part=""
swap="1G"
root="10G"
User=timon
PW=1234
root_PW=1234
confirm="--noconfirm"
