#!/bin/bash

source ./formats.sh

if has_nvidia; then
  echo -e "\e[32m[NVIDIA CONFIGURATION]\e[0m"
  mkinit=/etc/mkinitcpio.conf
  if [ ! -f "${mkinit}.bak" ]; then
    sudo cp $mkinit "${mkinit}.bak"
    sudo sed -i '/^MODULES=/c\MODULES=(nvidia nvidia_modeset nvidia_uvm nvidia_drm)' $mkinit
  else
    echo -e "${skip_f} mkinitcpio.conf is already configured"
  fi

  modfile=/etc/modprobe.d/nvidia.conf
  if [ ! -f $modfile ] && [ ! -f "${modfile}.bak" ]; then
    echo "options nvidia_drm modeset=1 fbdev=1" | sudo tee $modfile &> /dev/null
  else
    echo -e "${skip_f} modprobe.d is already configured"
  fi

  sudo mkinitcpio --config /etc/mkinitcpio.conf --generate /boot/initramfs-custom.img
  sed -i '/^#source/c\source=$src/hypr/env.conf            # ENV variables' ~/HyprBash/.config/hypr/hyprland.conf
fi
