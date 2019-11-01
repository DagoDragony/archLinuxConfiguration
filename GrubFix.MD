# Grub fix

`mount /dev/sda1 /mnt`

`arch-chroot /mnt`

`mkdir /boot/grub`

`grub-mkconfig -o /boot/grub/grub.cfg`
kernel images should be already in boot folder(for new installations)

`cd /boot/grub`

`grub-install /dev/sda`