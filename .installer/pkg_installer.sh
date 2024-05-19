#!/bin/bash

# Sourcing package functions
source ./pkg_functions.sh
if [ $? -eq 1 ]; then
  echo "Error sourcing file"
  exit 1
fi

# Takes spaces as delimiter
packages=($(awk '{print $1}' ./default_packages.txt))


# Packages installation
yay_installer

for pkg in "${packages[1]}"; do
  echo "Hello"
done

# TODO: export XDG_CONFIG_HOME="$HOME/HyprBash/.config"
