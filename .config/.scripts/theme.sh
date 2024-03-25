#!/bin/bash

# Sourcing global variables
# Executing source global.sh doesn't work
path=$(dirname "$(realpath "$0")")
source "$path/global.sh"

# Functions
print_theme() {
  echo ID: $saved_theme
  echo Theme: $theme
}

next_theme() {
  # print_theme
  if [ $saved_theme -lt $theme_quantity ]; then
    ((saved_theme++))
  else
    saved_theme=0
  fi

  save_values "$saved_theme" "$saved_wallpaper"
  show_wallpaper
}

prev_theme() {
  # print_theme
  if [ $saved_theme -gt 0 ]; then
    ((saved_theme--))
  else
    saved_theme=$((theme_quantity))
  fi

  save_values "$saved_theme" "$saved_wallpaper"
  show_wallpaper
}

while getopts "np" opt; do
	case $opt in
		n) next_theme;;
		p) prev_theme;;
		*) echo "n: Next theme"
		   echo "p: Previous theme"
		   exit 1;;
	esac
done
