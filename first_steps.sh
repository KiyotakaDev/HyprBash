#!/bin/bash

# Script for pre-install configuration (pacman and grup)
# Importing functions
source installer_fns.sh

# Pacman configuration
# If pacman conf exists and is does not have a back up; then
if [ -f /etc/pacman.conf ] && [ ! -f /etc/pacman.conf.bak ]; then
  echo -e "\e[33m[PACMAN]\e[0m making pacman prettier."
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
  echo -e "\e[33m[PACMAN]\e[0m succesfully configured ^u^"
else
  echo -e "\e[7;37m[SKIP]\e[0m pacman is already configured"
fi
