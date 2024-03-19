#!/bin/bash

# NOTE: /dev/null is a special device that discards
# everything that is wirtten in avoding any output.
# INFO: For more detailed command params info execute the 
# following pattern:
#   echo `pacman --help` # shows params
#   echo `pacman -param --help`
#   echo `grep --help`

# Text formats
skip_f="\e[1;47;30m[SKIP]\e[0m"
pacman_f="\e[33m[PACMAN]\e[0m"
bootldr_f="\e[32m[BOOTLOADER]\e[0m"
pkg_f="\e[36m[PACKAGE]\e[0m"
error_f="\e[31m[ERROR]\e[0m"

# Constants
path=`dirname "$(dirname "$(realpath "$0")")"`

# Checks if the package is installed
is_pkg_installed() {
	local ChkPkg=$1
	if pacman -Qq $ChkPkg &> /dev/null; then
		# echo -e "\e[32m[$ChkPkg]\e[0m is installed"
		return 0
	else
		# echo -e "\e[31m[$ChkPkg]\e[0m is NOT installed"
		return 1
	fi
}

# Checks if the package is on arch repos
is_pkg_available() {
  local ChkPkg=$1
  if pacman -Ss $ChkPkg &> /dev/null; then
    # echo -e "\e[32m[$ChkPkg]\e[0m is available on arch repo"
    return 0
  else
    # echo -e "\e[31m[$ChkPkg]\e[0m is NOT available on arch repo"
    return 1
  fi
}

# Checks if user has yay or paru aur helpers
chk_aur() {
  if is_pkg_installed yay; then
    aurhlpr="yay"
  elif is_pkg_insalled paru; then
    aurhlpr="paru"
  fi
}

# Checks if the package is on aur repos
is_aur_available() {
  local ChkPkg=$1
  chk_aur

  if [ -n "$aurhlpr" ]; then
    if $aurhlpr -Ss $ChkPkg &> /dev/null; then
      echo -e "\e[32m[$ChkPkg]\e[0m is available on aur repo"
    else
      echo -e "\e[31m[$ChkPkg]\e[0m is NOT available on aur repo"
    fi
  else
    echo "AUR helper is not installed."
  fi
}

# Install AUR helper function
aur_installer() {
  # Default value :-yay
  hlpr="${1:-yay}"

  # Checks  if ~/Clone is a directory
  if [ -d ~/Clone ]; then
    echo "~/Clone directory already exists"
    rm -rf ~/Clone/$hlpr
  else
    # Making dir and giving to it git icon
    mkdir ~/Clone
    # Git icon
    echo -e "[Desktop Entry]\nIcon=default-folder-git" > ~/Clone/.directory
    echo "~/Clone direcotry created."
  fi

  # Checks if git is installed and then installs aur helper selected by user
  if is_pkg_installed git; then
    git clone https://aur.archlinux.org/$hlpr.git ~/Clone/$hlpr
  else
    echo "Git is not installed pls install"
    exit 1
  fi

  # Changes dir and completes installation
  cd ~/Clone/$hlpr
  echo -e "\e[35m[MAKEPKG]\e[0m"
  makepkg -si

  # If previous command success then
  if [ $? -eq 0 ]; then
    echo -e "${pkg_f}\e[32m|$hlpr|\e[0m AUR successfully installed UwU"
    exit 0
  else
    echo -e "${error_f} Something went wront UnU"
    exit 1
  fi
}

# Checks if user has NVIDIA GPU for additional configuration >u<
has_nvidia() {
  if lspci | grep -Eiq "(vga|nvidia|3d)"; then
    # echo -e "\e[32m[NVIDIA-GPU]\e[0m detected :D"
    return 0
  else
    # echo -e "\e[31m[NVIDIA-GPU]\e[0m not detected"
    return 1
  fi
}
