#!/bin/bash

# Sourcing variables
source "$HOME/HyprBash/.scripts/state.sh"

change_theme() {
  set_current
  local motion=$1
  current_wallpaper=1

  get_theme_quantity

  if [ "$motion" = "next" ]; then
    if [ "$current_theme" -lt "$THEME_QUANTITY" ]; then
      next_theme=$((current_theme+1)) 
    else
      next_theme=1
    fi 
  elif [ "$motion" = "prev" ]; then
    if [ "$current_theme" -gt 1 ]; then
      next_theme=$((current_theme-1))
    else
      next_theme=$THEME_QUANTITY
    fi
  fi

  echo "$next_theme,$current_wallpaper" > $STATE_FILE
  set_wallpaper "$next_theme" "$current_wallpaper"
}
