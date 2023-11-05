lang = "de-latin1"
disk = "nvmen1"

if ! ping -c 1 "1.1.1.1" &> /dev/null; then
  echo "No Internet Connection"
  exit 1
fi

loadkeys $lang

if ! ls /sys/firmware/efi/efivars &> /dev/null; then
  echo "Not UEFI"
  exit 1
fi

(
echo g
echo n 
echo 1 
echo  
echo +550M  
echo n 
echo 2
echo   
echo +10G  
echo n 
echo 3 
echo   
echo +50G
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
) | fdisk /dev/$disk

mkfs.fat -F 32 -n ARCH_BOOT /dev/'$disk'p1
mkswap -L SWAP /dev/'$disk'p2
mkfs.ext4 -L ARCH_ROOT /dev/'$disk'p3
mkfs.ext4 -L ARCH_HOME /dev/'$disk'p4

swapon /dev/'$disk'p2
mount /dev/'$disk'p3 /mnt
mkdir /mnt/boot
mount /dev/'$disk'p1 /mnt/boot
mkdir /mnt/home
mount /dev/'$disk'p4 /mnt/home

cp -r ./ /mnt/home/AutoArch

pacstrap /mnt base base-devel linux linux-firmware \
        refind ntfs-3g unzip wget networkmanager

arch-chroot /mnt /home/AutoArch/install.sh

