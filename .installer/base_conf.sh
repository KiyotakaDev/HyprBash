#!/bin/bash

# Function to handle source error
handle_error() {
  echo -e "\e[31m[ERROR]\e[0m $1"
  exit 1
}
# Sourcing files
source ./pkg_functions.sh || handle_error "Sourcing functions file" 
source ./formats.sh || handle_error "Sourcing formats file"

# Pacman configuration
if [ -f /etc/pacman.conf ] && [ ! -f /etc/pacman.conf.bak ]; then
  echo -e "${pacman_f} configuration"
  # Backup file
  sudo cp /etc/pacman.conf /etc/pacman.conf.bak

  # Color, ParallelDownloads, VerbosePkgLists and ILoveCandy
  sudo sed -i "/^#Color/s/^#//
  /^#ParallelDownloads/s/^#//
  /^#VerbosePkgLists/s/^#//
  /ParallelDownloads/a\ILoveCandy" /etc/pacman.conf

  sudo pacman -Syu
  echo -e "${pacman_f} succesfully configured ^u^"
else
  echo -e "${skip_f} pacman already configured..."
fi

# Grub configuration
if [ ! -f /etc/default/grub.bak ] && [ ! -f /boot/grub/grub.cfg.bak ]; then
  echo -e "${boot_f} configuration"
  # Backup
  sudo cp /etc/default/grub /etc/default/grub.bak
  sudo cp /boot/grub/grub.cfg /boot/grub/grub.cfg.bak

  if has_nvidia; then
    echo -e "${boot_f} NVIDIA detected, adding \"nvidia_drm.modset=1\" to boot option"
    sudo sed -i "/^GRUB_TIMEOUT=/s/[0-9]\+$/15/ 
      /GRUB_DEFAULT/c\GRUB_DEFAULT=true 
      /#GRUB_SAVEDEFAULT=/s/^#//" /etc/default/grub
    sudo sed -i -e '/^GRUB_CMDLINE_LINUX_DEFAULT=/s/".*"/"nvidia_drm.modeset=1"/' /etc/default/grub
  fi

  # THEME
  echo -e "\e[36m[GRUB THEME]\e[0m"
  themePath=~/HyprBash/assests/grub/void_theme.tar.gz
  if [ -e $themePath ]; then
    sudo tar -xzf ${themePath} -C /usr/share/grub/themes
    # Change THEME
    sudo sed -i "/GRUB_GFXMODE/c\GRUB_GFXMODE=\2560x1440,1680x1050,auto
    /^#GRUB_THEME/c\GRUB_THEME=\"/usr/share/grub/themes/void_theme/theme.txt\"" /etc/default/grub
    # Make grub config file
    sudo grub-mkconfig -o /boot/grub/grub.cfg
  fi
else
  echo -e "${skip_f} GRUB is already configured"
fi
