#!/bin/sh
# https://wiki.archlinux.org/index.php/Installation_guide

# KEYBOARD
loadkeys /usr/share/kbd/keymaps/i386/qwerty/br-abnt2.map.gz

# DATE/TIME
timedatectl set-ntp true

# PARTITION
umount /mnt/boot
umount /mnt/home
umount /mnt
swapoff -a
mkfs.vfat -F32 /dev/sda1
mkfs.ext4 /dev/sda2
mkswap /dev/sda3
mkfs.ext4 /dev/sda4
swapon -a
mount /dev/sda2 /mnt
mkdir /mnt/home
mkdir /mnt/boot
mount /dev/sda1 /mnt/boot
mount /dev/sda4 /mnt/home

# BACKUP
cp ~/script.sh /mnt/home/script.sh

# ARCHLINUX
pacstrap /mnt base base-devel intel-ucode nvidia

# FSTAB
genfstab -U /mnt >> /mnt/etc/fstab

# LOCALE
ln -sf /usr/share/zoneinfo/America/Fortaleza /mnt/etc/localtime
sed -i 's/#en_US.UTF-8/en_US.UTF-8/g' /mnt/etc/locale.gen
sed -i 's/#pt_BR.UTF-8/pt_BR.UTF-8/g' /mnt/etc/locale.gen
echo 'LANG=en_US.UTF-8' > /mnt/etc/locale.conf
echo 'LANG=pt_BR.UTF-8' >> /mnt/etc/locale.conf
echo 'KEYMAP="br-abnt2.map.gz"' > /mnt/etc/vconsole.conf

# HOSTNAME
echo 'leandro-pc' > /mnt/etc/hostname

# CHANGE ROOT INTO THE NEW SYSTEM
# arch-chroot /mnt

# GENERATE /etc/adjtime
# hwclock --systohc

# GENERATE LOCALE
# locale-gen

# SET THE ROOT PASSWORD
# passwd

# CONFIGURE BOOT
# bootctl install
