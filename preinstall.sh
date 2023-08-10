ping 1.1.1.1
lsblk
cfdisk /dev/drive
#gpt -> 
#Boot 550M bootflag vfat
#Primary
mkfs.ext4 /dev/first patition
mkfs.ext4 /dev/second patition
mount /dev/second patition /mnt
mkdir /mnt/boot
mount /dev/first patition /mnt/boot
pacstrap /mnt base base-devel linux linux-firmare
arch-chroot /mnt /bin/bash
###########################
#make you settings
###########################
genfstab -U /mnt >> /mnt/etc/fstab
umount -R /mnt
reboot
