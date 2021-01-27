#!/usr/bin/env bash

sudo pacman -S samba
# needed to create empty /etc/samba/smb.conf

smbpasswd -r root.adform.com -U d.gaizutis
smbpasswd -r adform.com -U d.gaizutis

