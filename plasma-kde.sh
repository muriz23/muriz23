#!/bin/bash

mkdir.fat -F32 /dev/sda1
mkdir.ext4 /dev/sda2

mount /dev/sda2 /mnt
mkdir /mnt/boot
mount /dev/sda1 /mnt/boot

pacstrap -i /mnt base linux linux-firmware base-devel git nano sudo firefox terminator

genfstab -U /mnt >> /mnt/etc/fstab

arch-chroot /mnt/bin/bash

echo "en_US.UTF-8"
locale-gen

echo "LANG=en_US.UTF-8" >> /etc/locale.conf
echo"muriz" >> /etc/hostname
echo"127.0.0.1 localhost.localdomain muriz

passwd

pacman -S --nonconfirm grub efibootmgr networkmanager network-manager-applet dialog wpa_supplicant mtools dosfstools reflector linux-headers avahi xdg-user-dirs xdg-utils gvfs xorg xorg-xinit xorg-server sddm plasma plasma-nm plasma-pa powerdevil

mkdir /boot/efi
mount /dev/sda1/efi
grub-install --target=x86_64-efi-directory=/boot/efi --bootloader-id=GRUB
grub-mkconfig -o /boot/grub.cfg
grub-install /dev/sda
grub-mkconfig -o /boot/grub/grub.cfg


systemctl enable NetworkManager
systemctl enable sddm

passwd

useradd -m -g users -G wheel -s /bin/bash muriz
passwd muriz

exit umount -R /mnt
reboot


