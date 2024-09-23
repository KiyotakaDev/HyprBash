#!/bin/bash

STATE_FILE="$HOME/HyprBash/.scripts/.wallpaper_state"

if [ ! -f "$STATE_FILE" ]; then
  echo "abstract,1" > "$STATE_FILE"
fi

# Variables
current_theme=
current_wallpaper=
WALL_QUANTITY=

set_current() {
  # Internal Field Separator (abstract,1) => abstract 1
  IFS=',' read current_theme current_wallpaper < "$STATE_FILE"
}

# Gets the amount of images in the directory
get_wall_quantity() {
  local wall_dir="$HOME/HyprBash/assests/swww/$current_theme"

  if [ -d "$wall_dir" ]; then
    WALL_QUANTITY=$(ls "$wall_dir" | wc -l)
  else
    WALL_QUANTITY=1
  fi
}

