#!/bin/bash

# Sourcing global variables
# Executing source gobal.sh doesn't work
path=`dirname "$(realpath "$0")"`
source "$path/global.sh"

# Functions
print_data() {
  echo ID: $curr_wallpaper
  echo Wallpaper: $wallpaper
}

next_wallpaper() {
  print_data
  if [ $curr_wallpaper -lt $wallpaper_quantity ]; then
    ((curr_wallpaper++))
  else
    curr_wallpaper=0
  fi
}

prev_wallpaper() {
  print_data
  if [ $curr_wallpaper -gt 0 ]; then
    ((curr_wallpaper--))
  else
    curr_wallpaper=$wallpaper_quantity
  fi
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

save_values
