#!/bin/bash

# NOTE: /dev/null is a special device that discards
#       everything that is wirtten in avoding any output

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
