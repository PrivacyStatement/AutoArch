source ./scripts/func_vars.sh
source ./settings.sh

if ! ping -c 1 "1.1.1.1" &> /dev/null; then
  echo -e "${Red}No Internet Connection${Color_Off}"
  exit 1
fi
wait_input "Internet Connection Confirmt"

pacman -Sy --noconfirm figlet
wait_input "Figlet Installed"


figlet "Testing UEFI"
if ! ls /sys/firmware/efi/efivars &> /dev/null; then
  echo "${Red}Not UEFI${Color_Off}"
  exit 1
fi
wait_input "UEFI Used"

loadkeys $lang
wait_input "Keyboard layout $lang loaded"

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

mkfs.fat -F 32 -n ARCH_BOOT "/dev/${disk}${disk_part}1"
mkswap -L SWAP "/dev/${disk}${disk_part}2"
mkfs.ext4 -F -L ARCH_ROOT "/dev/${disk}${disk_part}3"
mkfs.ext4 -F -L ARCH_HOME "/dev/${disk}${disk_part}4"

swapon "/dev/${disk}${disk_part}2"
mount "/dev/${disk}${disk_part}3" /mnt
mkdir /mnt/boot
mount "/dev/${disk}${disk_part}1" /mnt/boot
mkdir /mnt/home
mount "/dev/${disk}${disk_part}4" /mnt/home

chmod 777 ./install.sh
cp -r ./ /mnt/home/AutoArch

pacstrap /mnt base base-devel linux linux-firmware \
        refind ntfs-3g unzip wget networkmanager sddm

arch-chroot /mnt /home/AutoArch/install.sh
genfstab -U /mnt >> /mnt/etc/fstab
