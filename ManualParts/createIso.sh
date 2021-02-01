#!/usr/bin/env bash

# install/update archiso
yay -Syy
yay -S --noconfirm archiso

initialArchFolder=$(mktemp -d)
cp -r /usr/share/archiso/configs/releng/* $initialArchFolder

echo "git" >> $initialArchFolder/packages.x86_64
echo "pacman-contrib" >> $initialArchFolder/packages.x86_64
echo "gptfdisk" >> $initialArchFolder/packages.x86_64

git clone https://github.com/DagoDragony/archLinuxConfiguration.git $initialArchFolder/airootfs/root/archLinuxConfiguration

workingDir=$(mktemp -d)
outputArchFolder=$(mktemp -d)
sudo mkarchiso -v -w $workingDir -o $outputArchFolder $initialArchFolder

outputIso=$(ls $outputArchFolder/*.iso)
cp $outputIso ~/
# run_archiso -i $outputIso


# dd if=/home/dago/Downloads/archlinux-2021.01.01-x86_64.iso of=/dev/sdb bs=512 status=progress # make bootable disk