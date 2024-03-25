#!/bin/bash

# Path
src_path=$(dirname "$(dirname "$(realpath "$0")")")
theme_path="${src_path}/swww"
conf_file="${theme_path}/.wallpaper_values.conf"

# Themes
themes=("deep_green" "neon")

# Check if file exists, if not create it.
if [ ! -e "$conf_file" ]; then
  echo "saved_theme=0" > "$conf_file"
  echo "saved_wallpaper=0" >> "$conf_file"
fi
# File source
source "$conf_file"

# Variables
theme="${themes[$saved_theme]}"
theme_quantity=$((${#themes[@]} - 1))
wallpapers=("$theme_path/$theme"/*)
wallpaper=${wallpapers[$saved_wallpaper]}
wallpaper_quantity=$((${#wallpapers[@]} - 1))

# Global functions
save_values() {
  echo "saved_theme=$1" > "$conf_file"
  echo "saved_wallpaper=$2" >> "$conf_file"
}

show_wallpaper() {
  local t_type=${1:-"grow"}

  swww img --transition-type $t_type \
           --transition-pos 0.5,0.5 \
           --transition-step 90 \
           "$wallpaper"
}
