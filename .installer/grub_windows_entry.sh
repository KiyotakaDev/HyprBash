#!/bin/bash

DEV=$(sudo fdisk -l | grep -i "100M EFI" | awk '{print $1}')
UUID=$(sudo blkid "$DEV" | awk -F '"' '{print $2}')

custom_path=/etc/grub.d/40_custom
[ -f "${custom_path}.bak" ] && exit 1

sudo cp "$custom_path" "${custom_path}.bak"

sudo bash -c "cat >> $custom_path << 'EOF'

menuentry \"Windows 11\" --class windows --class os {
  search --fs-uuid --no-floppy --set=root $UUID
  chainloader (\${root})/EFI/Microsoft/Boot/bootmgfw.efi
}
EOF"
