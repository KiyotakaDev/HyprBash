#!/bin/bash

# Sourcing global variables
# Executing source gobal.sh doesn't work
path=$(dirname "$(realpath "$0")")
source "$path/global.sh"

# Functions
print_data() {
  echo ID: $saved_wallpaper
  echo Wallpaper: $wallpaper
}

next_wallpaper() {
  print_data
  if [ $saved_wallpaper -lt $wallpaper_quantity ]; then
    ((saved_wallpaper++))
  else
    saved_wallpaper=0
  fi

  save_values "$saved_theme" "$saved_wallpaper"
  show_wallpaper
}

prev_wallpaper() {
  print_data
  if [ $saved_wallpaper -gt 0 ]; then
    ((saved_wallpaper--))
  else
    saved_wallpaper=$wallpaper_quantity
  fi

  save_values "$saved_theme" "$saved_wallpaper"
  show_wallpaper
}

while getopts "np" opt; do
  case $opt in
    n) next_wallpaper;;
    p) prev_wallpaper;;
    *) echo "n: Next wallpaper"
       echo "p: Previous wallpaper"
       exit 1;;
  esac
done
