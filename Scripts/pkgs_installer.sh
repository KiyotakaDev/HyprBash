#!/bin/bash

# Importing functions
source installer_fns.sh

# Check if user has AUR helper installed
chk_aur
# If arhlpr is is empty and yay and paru are not installed; then
if [ -z $aurhlpr ] && `! is_pkg_installed yay && ! is_pkg_installed paru`; then
  echo -e "Select \e[32m|AUR|\e[0m helper:\n1) yay\n2) paru"
  read -p "Enter number: " usrinp
  
  case $usrinp in
    1) aurhlpr="yay";;
    2) aurhlpr="paru";;
    *) echo "Invalid option selected"
       exit 1;;
   esac
   echo -e "${pkg_f}\e[32m|${aurhlpr}|\e[0m AUR helper is being installed"
   # 2&>1 Shows both stdout and stderr shows (command output and error)
   aur_installer $aurhlpr 2>&1
 else
   echo -e "${skip_f}\e[32m|$aurhlpr|\e[0m is already installed :D"
fi

# Recieves file as script option
pkgs_list=${1}

while read -r pkg; do
  if is_pkg_installed "$pkg"; then
    echo -e "${skip_f} ${pkg} already installed."
  elif is_pkg_available "$pkg"; then
    echo -e "${pkg_f}\e[32m|${pkg}|\e[0m from ARCH official repo added to queue."
  elif is_aur_available "$pkg"; then
    echo -e "${pkg_f}\d[32m|${pkg}|\e[0m from AUR repo added to queue."
  else
    echo -e "${error_f} unknown ${pkg}."
  fi
done < $pkgs_list
