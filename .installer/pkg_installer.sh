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
yay_installer

# Arrays to store package list
arch_pkgs=()
yay_pkgs=()
error_pkgs=()

for pkg in "${packages[@]}"; do
  if ! is_arch_available "$pkg" && ! is_yay_available "$pkg"; then
    error_pkgs+=("$pkg")
  elif is_arch_available "$pkg"; then
    arch_pkgs+=("$pkg")
  elif is_yay_available "$pkg"; then
    yay_pkgs+=("$pkg")
  fi  
done

# TODO: export XDG_CONFIG_HOME="$HOME/HyprBash/.config"
