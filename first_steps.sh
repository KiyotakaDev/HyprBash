#!/bin/bash

# Script for pre-install configuration (pacman and grup)
# Importing functions
source installer_fns.sh

# Pacman configuration
# If pacman conf exists and is does not have a back up; then
if [ -f /etc/pacman.conf ] && [ ! -f /etc/pacman.conf.bak ]; then
  echo -e "${pacman_f} making pacman prettier."
  # Creates backup file
  sudo cp /etc/pacman.conf /etc/pacman.conf.bak
  
  # 1: Uncomment Color
  # 2: Uncomment ParallelDownloads
  # 3: Uncomment VerbosePkgLists 
  # 4: Append ILoveCandy bellow ParallelDownloads
  sudo sed -i "/^#Color/s/^#//
  /^#ParallelDownloads/s/^#//
  /^#VerbosePkgLists/s/^#//
  /ParallelDownloads/a\ILoveCandy" /etc/pacman.conf

  sudo pacman -Syu
  echo -e "${pacman_f} succesfully configured ^u^"
else
  echo -e "${skip_f} pacman is already configured"
fi

# Grub configuration
# If grub instaled and grub.cfg file exists; then
if is_pkg_installed grub && [ -f /boot/grub/grub.cfg ]; then
  echo -e "${bootldr_f} GRUB detected."

  if [ ! -f /etc/default/grub.bak ] && [ ! -f /boot/grub/grub.bak ]; then
    echo -e "${bootldr_f} config starts."
    
    # Check nvidia
    if has_nvidia; then
      echo -e "${bootldr_f} NVIDIA detected, adding nvidia_drm.modset=1 to boot option."
      # 1: Set timeout to 15
      # 2: Replace ".*" to "nvidia_drm.modeset=1"
      sed -e '/^GRUB_TIMEOUT=/s/[0-9]\+$/15/' \
          -e '/^GRUB_CMDLINE_LINUX_DEFAULT=/s/".*"/"nvidia_drm.modeset=1"/' /etc/default/grub
    fi

  fi
else
  echo -e "${skip_f} Grub is already configured"
fi
