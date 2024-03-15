#!/bin/bash

# Importing functions
source installer_fns.sh

pkgs_list=${1}

while read -r pkg; do
  if is_pkg_installed "$pkg"; then
    echo -e "${skip_f} ${pkg} already installed."
  elif is_pkg_available "$pkg"; then
    echo -e "${pkg_f}\e[32m|${pkg}|\e[0m from ARCH official repo added to queue."
  else
    echo -e "${error_f} unknown ${pkg}."
  fi
done < $pkgs_list
