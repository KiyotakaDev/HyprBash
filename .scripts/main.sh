#!/bin/bash

DIR="$HOME/HyprBash/.scripts/"

source "$DIR/state.sh"
source "$DIR/wallpaper.sh"
source "$DIR/theme.sh"

# Set current state
set_current

set_wallpaper() {
  local theme="$1"
  local wallpaper="$2"
  local animation=${3:-"wipe"}
  local wallpaper_path="$HOME/HyprBash/assests/swww/$theme/wall_$wallpaper.png"

  swww img --transition-type "$animation" \
           --transition-pos 0.5,0.5 \
           --transition-step 20 \
           --transition-fps 165 \
           "$wallpaper_path"
}
load_wallpaper() {
  local wallpaper_path="$HOME/HyprBash/assests/swww/$current_theme/wall_$current_wallpaper.png"

  swww img --transition-type wipe \
           --transition-angle 180 \
           --transition-step 20 \
           --transition-fps 165 \
           "$wallpaper_path"
}

while getopts "npcud" opt; do
  case "$opt" in
    n) change_wallpaper "next" "grow";;
    p) change_wallpaper "prev" "outer";;
    c) load_wallpaper;;
    u) change_theme "next";;
    d) change_theme "prev";;
    *) echo "n: Next wallpaper"
       echo "p: Prev wallpaper"
       echo "c: Current theme and wallpaper"
       echo "u: Next theme"
       echo "d: Prev theme"
  esac
done
