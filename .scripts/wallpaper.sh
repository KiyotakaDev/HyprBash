#!/bin/bash

# Sourcing variables
source "$HOME/HyprBash/.scripts/state.sh"

change_wallpaper() {
  set_current
  local motion=$1
  local animation=$2

  get_wall_quantity

  
  if [ "$motion" = "next" ]; then
    if [ "$current_wallpaper" -lt "$WALL_QUANTITY" ]; then
      next_wallpaper=$((current_wallpaper+1))
    else
      next_wallpaper=1
    fi
  elif [ "$motion" = "prev" ]; then
    if [ "$current_wallpaper" -gt 1 ]; then
      next_wallpaper=$((current_wallpaper-1))
    else
      next_wallpaper=$WALL_QUANTITY
    fi
  fi
  
  echo "$current_theme,$next_wallpaper" > $STATE_FILE
  set_wallpaper "$current_theme" "$next_wallpaper" "$animation"
}
