#!/bin/bash

STATE_FILE="$HOME/HyprBash/.scripts/.wallpaper_state"

if [ ! -f "$STATE_FILE" ]; then
  echo "abstract,1" > "$STATE_FILE"
fi

# Variables
current_theme=
current_wallpaper=
set_current() {
  # Internal Field Separator (abstract,1) => abstract 1
  IFS=',' read current_theme current_wallpaper < "$STATE_FILE"
  echo "$current_theme,$current_wallpaper"
}
set_current

next_wallpaper() {
  if [ "$current_wallpaper" -lt 3 ]; then
    new_wallpaper=$((current_wallpaper+1))
  else
    new_wallpaper=1
  fi

  echo "$current_theme,$new_wallpaper" > "$STATE_FILE"
  set_wallpaper "$current_theme" "$new_wallpaper"
}

prev_wallpaper() {
  if [ "$current_wallpaper" -gt 1 ]; then
    new_wallpaper=$((current_wallpaper-1))
  else
    new_wallpaper=3
  fi

  echo "$current_theme,$new_wallpaper" > "$STATE_FILE"
  set_wallpaper "$current_theme" "$new_wallpaper"
}


set_wallpaper() {
  theme="$1"
  wallpaper="$2"
  wallpaper_path="$HOME/HyprBash/assests/swww/$1/wall_$2.png"

  swww img --transition-type grow \
           --transition-pos 0.5,0.5 \
           --transition-step 20 \
           --transition-fps 165 \
           "$wallpaper_path"
}

while getopts "npc" opt; do
  case "$opt" in
    n) next_wallpaper;;
    p) prev_wallpaper;;
    c) set_wallpaper "$current_theme" "$current_wallpaper";;
    *) echo "n: Next wallper"
       echo "p: Prev wallpaper"
       exit 1;;
  esac
done
