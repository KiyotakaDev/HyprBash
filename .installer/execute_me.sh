#!/bin/bash

# Function to handle source error
handle_error() {
  echo -e "\e[31m[ERROR]\e[0m $1"
  exit 1
}
# Sourcing files
source ./pkg_functions.sh || handle_error "Sourcing functions file" 
source ./formats.sh || handle_error "Sourcing formats file"

# 1: Base config script (pacman, grub)
./base_conf.sh

# 2: Packages installer script
./pkg_installer.sh ./default_packages.txt

# 3: NVIDIA specific config script 
./nvidia_conf.sh

# 4: Final config script (sddm, symlink, services)
./final_conf.sh

# 5: Needed for proper config work
./reboot_timer.sh
