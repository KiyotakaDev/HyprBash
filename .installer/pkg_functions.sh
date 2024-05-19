#!/bin/bash

# Sourcing formats
source ./formats.sh
if [ $? -eq 1 ]; then
  echo "Error sourcing formats"
fi


is_pkg_installed() {
  local pkg_to_check=$1

  if pacman -Qq "$pkg_to_check" &> /dev/null; then
    echo -e "$skip_f |$pkg_to_check| is already installed >.<"
  else
    echo -e "$pkg_f |$pkg_to_check| is not installed UnU"
  fi
}

is_arch_available() {
  local pkg_to_check=$1

  if pacman -Ss "$pkg_to_check" &> /dev/null; then
    echo -e "$pkg_f |$pkg_to_check| is on Arch repo"  
  else
    echo -e "$pkg_f |$pkg_to_check| is not on Arch repo"
  fi
}
is_yay_available() {
  local pkg_to_check=$1

  if yay -Ss "$pkg_to_check" &> /dev/null; then
    echo "Hello"
  else
    echo "Bye"
  fi
}

yay_installer() {
  if ! is_pkg_installed "git"; then
    echo "PKG git must be installed"
    sudo pacman -S git
  else
    echo "SKIP git is already installed"
  fi

  # echo "PKG yay installation"
  # git clone https://aur.archlinux.org/yay.git
  # cd yay
  # makepkg -si
}
