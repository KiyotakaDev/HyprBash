#!/bin/bash

# Importing functions
source installer_fns.sh


pkgs_list=${1}

while read -r pkg; do
  if ! is_pkg_installed "$pkg"; then
  else
    echo -e "\e["
