#!/bin/bash

# Function to handle source error
handle_error() {
  echo -e "\e[31m[ERROR]\e[0m $1"
  exit 1
}

# Source package functions
source ./pkg_functions.sh || handle_error "Sourcing functions file" 
source ./formats.sh || handle_error "Sourcing formats file"


# Extract package names, taking spaces as delimiter
packages=($(grep -E '^[^#]+[[:space:]]+#?' default_packages.txt | awk '{print $1}'))

# YAY helper installer
echo -e "\n\e[36m[INSTALLING HELPER ╰(▔∀▔)╯]\e[0m"
yay_installer

# Arrays to store package list
arch_pkgs=()
yay_pkgs=()
error_pkgs=()

echo -e "\n\e[36m[LISTING PACKAGES (￣▽￣)]\e[0m"
for pkg in "${packages[@]}"; do
  if is_pkg_installed "$pkg"; then
    echo -e "${skip_f}\e[32m|$pkg|\e[0m is already installed."
  elif ! is_arch_available "$pkg" && ! is_yay_available "$pkg"; then
    error_pkgs+=("$pkg")
  elif is_arch_available "$pkg"; then
    echo -e "${pkg_f}\e[32m|$pkg|\e[0m from ARCH repo queued"
    arch_pkgs+=("$pkg")
  elif is_yay_available "$pkg"; then
    echo -e "${pkg_f}\e[32m|$pkg|\e[0m from YAY repo queued"
    yay_pkgs+=("$pkg")
  fi  
done

echo -e "\n\e[36m[INSTALLING PACKAGES o(≧▽≦)o]\e[0m"
if [ "${#arch_pkgs[@]}" -gt 0 ]; then
  sudo pacman -S "${arch_pkgs[@]}"
fi
if [ "${#yay_pkgs[@]}" -gt 0 ]; then
  yay -S "${yay_pkgs[@]}"
fi
if [ "${#error_pkgs[@]}" -gt 0 ]; then
  echo -e "${error_f}\e[32m|$pkg|\e[0m not found"
fi

# TODO: export XDG_CONFIG_HOME="$HOME/HyprBash/.config"
