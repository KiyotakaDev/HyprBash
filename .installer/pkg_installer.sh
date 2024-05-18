#!/bin/bash

# Takes spaces as delimiter
packages=($(awk '{print $1}' ./default_packages.txt))

is_pkg_installed() {
  local pkg_to_check=$1

  if pacman -Qq "$pkg_to_check" &> /dev/null; then
    return 0 # Installed
  else
    return 1 # Not installed
  fi
}

for pkg in "${packages[@]}"; do
  if is_pkg_installed "$pkg"; then
    echo "SKIP $pkg"
  else
    echo "PKG $pkg queued"
  fi
done

# TODO: export XDG_CONFIG_HOME="$HOME/HyprBash/.config"
