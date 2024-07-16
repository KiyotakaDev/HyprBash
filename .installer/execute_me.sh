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
# ./pkg_installer.sh ./default_packages.txt

# Symbolic link for ~/HyprBash/.config/* files
if [ ! -d ~/.config-bak ]; then
  echo -e "\e[36m[SYMLINK GENERATION]\e[0m"
  mv ~/.config ~/.config-bak
  mkdir ~/.config
  ln -s ~/HyprBash/.config/* ~/.config
else
  echo -e "${skip_f}\e[36m[SYMLINK]\e[0m"
fi

# NVIDIA configuration
./nvidia_conf.sh

# Base configuration (pacman & grub)
./base_conf.sh
