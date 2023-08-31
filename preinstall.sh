ping 1.1.1.1
loadkeys de-latin1

lsblk
cfdisk /dev/drive

#uefi
ls /sys/firmware/efi/efivars

fdisk /dev/drive
#g

#n -> default -> +550M -> t -> ef
#n -> default -> +10G -> t -> 82
#n -> default -> +30G -> t -> Linux filesystem
#n -> default -> default -> t -> Linux filesystem
#a first patition
#p
#w

mkfs.fat -F 32 -n BOOT /dev/xY
mkswap -L SWAP /dev/xY
mkfs.ext4 -L ROOT /dev/xY
mkfs.ext4 -L HOME /dev/xY


#gpt -> 
#Boot 550M bootflag vfat
#Primary

swapon /dev/second patition 
mount /dev/third patition /mnt
mkdir /mnt/boot
mount /dev/first patition /mnt/boot
mkdir /mnt/home
mount /dev/fourth patition /mnt/home

pacstrap /mnt base base-devel linux linux-firmware
arch-chroot /mnt /bin/bash
###########################
#make you settings
###########################
#genfstab -U /mnt >> /mnt/etc/fstab
#reboot
