#!/bin/bash

# Sourcing package functions
source ./pkg_functions.sh
if [ $? -eq 1 ]; then
  echo "Error sourcing file"
  exit 1
fi

# Takes spaces as delimiter
packages=($(grep -E '^[^#]+[[:space:]]+#?' default_packages.txt | awk '{print $1}'))

for pkg in "${packages[@]}"; do
  is_pkg_installed "$pkg"
done

# TODO: export XDG_CONFIG_HOME="$HOME/HyprBash/.config"
