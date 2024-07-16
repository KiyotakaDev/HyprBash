#!/bin/bash

# Sourcing formats
source ./formats.sh
if [ $? -eq 1 ]; then
  echo "Error sourcing formats"
fi


is_pkg_installed() {
  local pkg_to_check=$1

  if pacman -Qq "$pkg_to_check" &> /dev/null; then
    # echo -e "$skip_f |$pkg_to_check| is already installed."
    return 0
  else
    # echo -e "$pkg_f |$pkg_to_check| is NOT installed."
    return 1
  fi
}

is_arch_available() {
  local pkg_to_check=$1

  if pacman -Ss "$pkg_to_check" &> /dev/null; then
    # echo -e "$pkg_f |$pkg_to_check| is on Arch repo."
    return 0
  else
    # echo -e "$pkg_f |$pkg_to_check| is NOT on Arch repo."
    return 1
  fi
}
is_yay_available() {
  local pkg_to_check=$1

  if yay -Ss "$pkg_to_check" &> /dev/null; then
    # echo -e "$pkg_f |$pkg_to_check| is on YAY repo."
    return 0
  else
    # echo -e "$pkg_f |$pkg_to_check| is NOT on YAY repo."
    return 1
  fi
}

yay_installer() {
  if ! is_pkg_installed "git"; then
    echo -e "$pkg_f |git| must be installed"
    sudo pacman -S git
  else
    echo -e "$skip_f |git| is already installed"
  fi

  if is_pkg_installed "yay"; then
      echo -e "\e[36m[HELPER ALREADY INSTALLED (*¯︶¯*)]\e[0m"
  else
    echo -e "${pkg_f}\e[32m|yay|\e[0m ready to install."
    mkdir ~/yay
    git clone https://aur.archlinux.org/yay.git ~/yay
    cd ~/yay
    makepkg -si

    if [ $? -eq 0 ]; then
      echo -e "\n\e[36m[HELPER INSTALLED ＼(≧▽≦)／]\e[0m"
      exit 0
    fi
  fi
}

has_nvidia() {
  if lspci | grep -Eiq "(VGA|nvidia|3d)"; then
    # echo -e "\e[31m[NVIDIA-GPU]\e[0m detected :D"
    return 0;
  else
    # echo -e "\e31m[NVIDIA-GPU]\e[0m not detected"
    return 1;
  fi
}
