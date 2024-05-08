#!/bin/bash

# Importing functions
source installer_fns.sh

if has_nvidia; then
  echo -e "\e[32m[NVIDIA]\e[0m Additional configuration"
  # Install hyprland nvidia dependencies but first check
  pkgs_to_chk=(nvidia-dkms linux-headers)
  for pkg in "${pkgs_to_chk[@]}"; do
    if ! is_pkg_installed $pkg; then
      sudo pacman -S $pkg
    else
      echo -e "${skip_f}\e[36m|$pkg|\e[0m already installed"
    fi
  done

  # Initramfs generation
  echo -e "\e[36m[INITRAMFS-GENERATION]\e[0m"
  sudo mkinitcpio -P
  # Adding modules to mkinitcpio
  mkinit=/etc/mkinitcpio.conf
  if [ ! -f "${mkinit}.bak" ]; then
    sudo cp $mkinit "${mkinit}.bak"
    sudo sed -i '/^MODULES=/c\MODULES=(nvidia nvidia_modeset nvidia_uvm nvidia_drm)' $mkinit
  else
    echo -e "${skip_f} mkinitcpio.conf is already configured"
  fi
  
  # Generating custom image
  echo -e "\e[36m[INITRAMFS-CUSTOM-IMAGE-GENERATION]\e[0m"
  sudo mkinitcpio --config /etc/mkinitcpio.conf --generate /boot/initramfs-custom.img

  # Checking if file exist backup file if not create file
  modfile=/etc/modprobe.d/nvidia.conf
  if [ -f $modfile ] && [ ! -f "${modfile}.bak" ]; then
    sudo cp $modfile "${modfile}.bak"
    echo -e "\e[32m|options nvidia-drm modeset=1|\e[0m"
    echo "options nvidia-drm modeset=1" | sudo tee -a $modfile &> /dev/null
  elif [ ! -f $modfile ]; then
    # Text | Shell root init > /etc/modprobe.d/nvidia/conf
    echo -e "\e[32m|options nvidia-drm modeset=1|\e[0m"
    echo "options nvidia-drm modeset=1" | sudo tee $modfile &> /dev/null
  else
    echo -e "${skip_f} modprobe.d is already configured"
  fi
fi

# SDDM Configuration
sddm=/etc/sddm.conf
sddmtemplate=/usr/lib/sddm/sddm.conf.d/default.conf
sddmconf() {
  echo -e "${dpmgr_f} SDDM configuration sugar candy based >u<"

  if [ ! -f $sddm ]; then
    sudo cp $sddmtemplate $sddm  
  fi
  
  if [ -f $sddm ] && [ ! -f "${sddm}.bak" ]; then
      sudo cp $sddm "${sddm}.bak"
      sudo tar -xzf "${path}/assets/sddm/riso.tar.gz" -C /usr/share/sddm/themes

      # Adding theme to sddm config
      sudo sed -i '/^Current=/s/^Current=.*/Current=riso/' $sddm
      echo "SDDM configuration succeed (*￣▽￣)b"
    else
      echo -e "${skip_f} SDDM already configured."
    fi
}
if is_pkg_installed sddm; then 
  sddmconf
else
  echo -e "${pkg_f}\e[32m|sddm|\e[0m is not installed."
  sudo pacman -S sddm
  echo -e "${dpmgr_f} retying configuration."
  sddmconf
fi

# Symbolic link for HyprBash configurations
ln -s ~/HyprBash/.config/* ~/.config 

# Enabling services and running services (is-active | is-enabled)
services=(sddm NetworkManager)
for srv in "$services"; do
  if systemctl is-enabled "$srv" &> /dev/null; then
    continue
  else
    echo -e "\e[36m[SYSTEMCTL]\e[0m enable and starting: \e[32m|"$srv"|\e[0m"
    sudo systemctl enable "${srv}.service"
    sudo systemctl start "${srv}.service"
  fi
done
