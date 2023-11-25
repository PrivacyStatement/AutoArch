source ./scripts/func_vars.sh
source ./settings.sh

ping -c 1 "1.1.1.1"
wait_input "Internet Connection Confirmed" "No Internet Connection"

pacman -Sy --noconfirm figlet
wait_input "Figlet Installed"


figlet "Testing UEFI"
ls /sys/firmware/efi/efivars
wait_input "UEFI Used" "Not UEFI" true

loadkeys $lang
wait_input "Keyboard layout $lang loaded" "Keyboard layout $lang couldn't get loaded"

figlet "Patition Drive ${disk}"
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
wait_input "Partitions created" "Drive Formatting failed"

mkfs.fat -F 32 -n ARCH_BOOT "/dev/${disk}${disk_part}1"
wait_input "Drive Formated /dev/${disk}${disk_part}1" "Drive Formatting failed /dev/${disk}${disk_part}1" false true
####################################################################################################################
mkswap -L SWAP "/dev/${disk}${disk_part}2"
wait_input "Drive Formated /dev/${disk}${disk_part}2" "Drive Formatting failed /dev/${disk}${disk_part}2" false true
####################################################################################################################
mkfs.ext4 -F -L ARCH_ROOT "/dev/${disk}${disk_part}3"
wait_input "Drive Formated /dev/${disk}${disk_part}3" "Drive Formatting failed /dev/${disk}${disk_part}3" false true
####################################################################################################################
mkfs.ext4 -F -L ARCH_HOME "/dev/${disk}${disk_part}4"
wait_input "Drive Formated /dev/${disk}${disk_part}4" "Drive Formatting failed /dev/${disk}${disk_part}4"

swapon "/dev/${disk}${disk_part}2"
wait_input "Mounted Swap" "Swap Mount failed" false true
####################################################################################################################
mount "/dev/${disk}${disk_part}3" /mnt
wait_input "Mounted /mnt" "/mnt Mount failed" false true
####################################################################################################################
mkdir /mnt/boot
mount "/dev/${disk}${disk_part}1" /mnt/boot
wait_input "Mounted /mnt/boot" "/mnt/boot Mount failed" false true
####################################################################################################################
mkdir /mnt/home
mount "/dev/${disk}${disk_part}4" /mnt/home
wait_input "Mounted /mnt/home" "/mnt/home Mount failed" false true

chmod 777 ./files/install.sh
wait_input "Files Copied and Priviled Elevated" "Files Copy or Priviled Elevat failed" false true
cp -r ./ /mnt/home/AutoArch
wait_input "Files Copied and Priviled Elevated" "Files Copy or Priviled Elevat failed" false true

figlet "Start pacstrap install"
pacstrap /mnt base base-devel linux linux-firmware \
        refind ntfs-3g unzip wget networkmanager sddm
wait_input "Filesystem created" "Filesystem creation failed"

figlet "Start install script in mounted Filesystem"
arch-chroot /mnt /home/AutoArch/install.sh

figlet "Create Fstab File"
genfstab -U /mnt >> /mnt/etc/fstab
wait_input "fstab created" "fstab creation failed"
