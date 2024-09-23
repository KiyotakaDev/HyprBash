#!/bin/bash

# Sourcing variables
source "$HOME/HyprBash/.scripts/state.sh"

change_theme() {
  set_current
  local motion=$1
  current_wallpaper=1

  local themes=($(ls "$HOME/HyprBash/assests/swww/"))
  local THEME_QUANTITY=${#themes[@]}

  # Find $current_theme index
  theme_index=-1
  for ((i = 0; i < THEME_QUANTITY; i++)); do
    if [ "${themes[i]}" == "$current_theme" ]; then
      theme_index=$i
      break
    fi
  done

  if [ "$motion" = "next" ]; then
    if [ "$theme_index" -lt "$THEME_QUANTITY" ]; then
      $((theme_index++))
    else
      theme_index=0
    fi
  elif [ "$motion" = "prev" ]; then
    if [ "$theme_index" -gt 0 ]; then
      $((theme_index--))
    else
      theme_index=$THEME_QUANTITY
    fi
  fi

  current_theme=${themes[$theme_index]}
  
  echo "$current_theme,$current_wallpaper" > $STATE_FILE
  set_wallpaper "$current_theme" "$current_wallpaper"
}
