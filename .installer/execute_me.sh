#!/bin/bash

# Function to handle source error
handle_error() {
  echo -e "\e[31m[ERROR]\e[0m $1"
  exit 1
}
# Sourcing files
source ./pkg_functions.sh || handle_error "Sourcing functions file" 
source ./formats.sh || handle_error "Sourcing formats file"

# Packages installer
./pkg_installer.sh ./default_packages.txt

if [ ! -d ~/.config-bak ]; then
  echo -e "\e[36m[SYMLINK GENERATION]\e[0m"
  mv ~/.config ~/.config-bak
  mkdir ~/.config
  ln -s ~/HyprBash/.config/* ~/.config
else
  echo -e "${skip_f}\e[36m[SYMLINK]\e[0m"
fi

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
