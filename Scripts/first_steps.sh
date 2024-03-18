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
    sudo cp /etc/default/grub /etc/default/grub.bak
    sudo cp /boot/grub/grub.cfg /boot/grub/grub.cfg.bak
    
    # Check nvidia
    if has_nvidia; then
      echo -e "\e[32m[NVIDIA]\e[0m installer"
      sudo pacman -S nvidia-dkms linux-headers
      echo -e "${bootldr_f} NVIDIA detected, adding nvidia_drm.modset=1 to boot option."
      # 1: Set timeout to 15
      # 2: Replace ".*" to "nvidia_drm.modeset=1"
      sudo sed -i -e '/^GRUB_TIMEOUT=/s/[0-9]\+$/15/' \
      -i -e '/^GRUB_CMDLINE_LINUX_DEFAULT=/s/".*"/"nvidia_drm.modeset=1"/' /etc/default/grub
    fi

    echo -e "\e[36m[GRUB THEME]\e[0m"
    # Custom theme
    echo -e "Select grub theme:\n1) Void\n2) Sky\n3) Starfield"
    read -p "Enter an option <or> Press enter to scape: " usrinp
    case ${usrinp} in
      1) theme="void";;
      2) theme="sky";;
      3) theme="starfield";;
      *) theme=;;
    esac

    if [ -n "$theme" ]; then
      echo -e "${bootldr_f}\e[36m|${theme}|\e[0m theme configuration :D"
      ThmPth=${path}/Source/${theme}_theme.tar.gz
      # Checks if the file exists
      if [ -e $ThmPth ]; then
        sudo tar -xzf ${ThmPth} -C /usr/share/grub/themes
      fi
      # Change the grub theme
      sudo sed -i "/GRUB_GFXMODE/c\GRUB_GFXMODE=\1920x1080,1680x1050,auto
      /^#GRUB_THEME/c\GRUB_THEME=\"/usr/share/grub/themes/${theme}_theme/${theme}_theme/theme.txt\"" /etc/default/grub
    else
      echo -e "${skip_f} grub theme configuration."
    fi

    # Makes grub config file
    sudo grub-mkconfig -o /boot/grub/grub.cfg
  fi
else
  echo -e "${skip_f} Grub is already configured"
fi
