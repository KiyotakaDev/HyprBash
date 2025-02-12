#!/bin/bash

# Function to handle source error
handle_error() {
  echo -e "\e[31m[ERROR]\e[0m $1"
  exit 1
}
# Sourcing files
source ./pkg_functions.sh || handle_error "Sourcing functions file" 
source ./formats.sh || handle_error "Sourcing formats file"

# 1: Packages installer script
if [[ $# -eq 0 ]]; then
  echo "This command needs a flag to be executed"
  echo "Execute with -h to know the flags"
  exit 1
fi

while getopts "dsch" opt; do
  case "$opt" in
    d) ./pkg_installer.sh ./dev_packages.txt;;
    s) ./pkg_installer.sh;;
    c) ./pkg_installer.sh $2;;
    h) echo -e "\t-d\tWith developer packages"
       echo -e "\t-s\tOnly system needed packages"
       echo -e "\t-c\tWith custom packages (cmd -c file/path/file.txt)"
       echo -e "\t-h\tList command flags"
       exit 1
      ;;
    *) echo "Command needs a flag. Execute with -h flag for more info"
       exit 1
       ;;
  esac
done

# 2: Base config script (pacman, grub)
./base_conf.sh

# 3: NVIDIA specific config script 
./nvidia_conf.sh

# 4: Final config script (sddm, symlink, services)
./final_conf.sh

# 5: Needed for the configs to work properly
./reboot_timer.sh
