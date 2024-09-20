#!/bin/bash

DIR="$HOME/HyprBash/.scripts/"

source "$DIR/state.sh"
source "$DIR/wallpaper.sh"
source "$DIR/theme.sh"

# Set current state
set_current

set_wallpaper() {
  theme="$1"
  wallpaper="$2"
  animation=${3:-"wipe"}
  wallpaper_path="$HOME/HyprBash/assests/swww/$1/wall_$2.png"

  swww img --transition-type "$animation" \
           --transition-pos 0.5,0.5 \
           --transition-step 20 \
           --transition-fps 165 \
           "$wallpaper_path"
}

while getopts "npcud" opt; do
  case "$opt" in
    n) change_wallpaper "next" "grow";;
    p) change_wallpaper "prev" "outer";;
    c) set_wallpaper "$current_theme" "$current_wallpaper";;
    u) change_theme "next";;
    d) change_theme "prev";;
    *) echo "n: Next wallpaper"
       echo "p: Prev wallpaper"
       echo "c: Current theme and wallpaper"
       echo "u: Next theme"
       echo "d: Prev theme"
  esac
done
