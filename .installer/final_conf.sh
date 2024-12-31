#!/bin/bash

source ./formats.sh
if [ $? -eq 1 ]; then
  echo "Error sourcing formats"
fi

# SDDM Config
sddm=/etc/sddm.conf
sddm_template=/usr/lib/sddm/sddm.conf.d/default.conf

echo -e "${display_f} SDDM configuration sugar candy based >u<"

if [ ! -f $sddm ]; then
  sudo cp $sddm_template $sddm
fi

if [ -f $sddm ] && [ ! -f "${sddm}.bak" ]; then
  sudo cp $sddm "${sddm}.bak"
  sudo tar -xzf ~/HyprBash/assests/sddm/zenless.tar.gz -C /usr/share/sddm/themes

  # Adding theme to SDDM config file
  sudo sed -i '/Current=/c\Current=zenless' $sddm
  echo "SDDM configuration succeed (*￣▽￣)b"
else
  echo -e "${skip_f} SDDM is already configured..."
fi

# Symbolic link for ~/HyprBash/.config/* files
if [ ! -d ~/.config_bak ]; then
  echo -e "\e[36m[SYMLINK GENERATION]\e[0m"
  mv ~/.config ~/.config_bak
  mkdir ~/.config
  ln -s ~/HyprBash/.config/* ~/.config
else
  echo -e "${skip_f}\e[36m[SYMLINK]\e[0m"
fi

# Tmux plugin manager
~/HyprBash/.scripts/tmux.sh


# Services
services=(sddm NetworkManager)
for service in "$services"; do
  if systemctl is-enabled "$service" &> /dev/null; then
    continue
  else
    echo -e "\e[36m[SYSTEMCTL]\e[0m enabling and starting: \e[32m|"$service"|\e[0m"
    sudo systemctl enable "${service}.service"
    sudo systemctl start "${service}.service"
  fi
done
