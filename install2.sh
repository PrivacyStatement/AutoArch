####################
####IMPORT FILES####
####################
source ./scripts/func_vars.sh
source ./settings.sh

####################
####CATCH ERRORS####
####################
trap 'handle_error $LINENO' ERR

####################
###NETWORK CHECK####
####################
ERROR_CODE="No Network Connection"  
ping -c 1 "1.1.1.1" 
success "Network Connected"

##Install Figlet##
ERROR_CODE="Figlet Install Failed"  
pacman -Sy --noconfirm figlet
success "Figlet Installed"

####################
CHAPTER "Testing UEFI"
####################

ERROR_CODE="System must be booted over UEFI"
ls /sys/firmware/efi/efivars
success "UEFI Used"

##Load Keyboard Layout##
ERROR_CODE="Keyboard layout $lang couldn't get loaded"
loadkeys $lang
success "Keyboard layout $lang loaded"

####################
CHAPTER "Patition Drive ${disk}"
####################
ERROR_CODE="Drive Partitioning failed"
(
echo g
echo n 
echo 1 
echo  
echo +550M  
echo n 
echo 2
echo   
echo +"${swap}"  
echo n 
echo 3 
echo   
echo +"${root}"
echo n
echo 4
echo   
echo
echo t
echo 1
echo uefi
echo t
echo 2
echo swap
echo t
echo 3
echo linux
echo t
echo 4
echo linux
echo w # Write changes
) | fdisk "/dev/${disk}"
success "
| Formatting Partitions |  DRIVE /dev/${disk}  |                      |                      |                      |
|-----------------------|----------------------|----------------------|----------------------|----------------------|
| Partitions            | ${disk}${disk_part}1 | ${disk}${disk_part}2 | ${disk}${disk_part}3 | ${disk}${disk_part}4 |
| Lable                 | ARCH_BOOT            | SWAP                 | ARCH_ROOT            | ARCH_HOME            |
| Format                | FAT32                | SWAP                 | EXT4                 | EXT4                 |
| Mount-point (/mnt)    | /boot                | swap                 | /                    | /home                |
"


####################
CHAPTER "Formatting Partitions"
####################
ERROR_CODE="Drive Partition failed /dev/${disk}${disk_part}1 | FAT32"
mkfs.fat -F 32 -n ARCH_BOOT "/dev/${disk}${disk_part}1"
ERROR_CODE="Drive Partition failed /dev/${disk}${disk_part}2 | SWAP"
mkswap -L SWAP "/dev/${disk}${disk_part}2"
ERROR_CODE="Drive Partition failed /dev/${disk}${disk_part}3 | EXT4"
mkfs.ext4 -F -L ARCH_ROOT "/dev/${disk}${disk_part}3"
ERROR_CODE="Drive Partition failed /dev/${disk}${disk_part}4 | EXT4"
mkfs.ext4 -F -L ARCH_HOME "/dev/${disk}${disk_part}4"
success "Partitions Created"

####################
######CLEAN UP######
####################
trap - ERR
