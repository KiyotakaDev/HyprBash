#!/bin/bash

DIR="$HOME/HyprBash/.scripts/"

source "$DIR/state.sh"
source "$DIR/wallpaper.sh"
source "$DIR/theme.sh"

# Set current state
set_current

# Variables
BASE="$HOME/HyprBash/assests/swww"

set_wallpaper() {
  local theme="$1"
  local wallpaper="$2"
  local animation=${3:-"wipe"}
  local wall_located=$(ls "$BASE/$theme/" | grep -E "wall_$wallpaper\.(jpg|png)")
  local wallpaper_path="$BASE/$theme/$wall_located"

  swww img --transition-type "$animation" \
           --transition-pos 0.5,0.5 \
           --transition-step 20 \
           --transition-fps 165 \
           "$wallpaper_path"
}

load_wallpaper() {
  local wall_located=$(ls "$BASE/$current_theme/" | grep -E "wall_$current_wallpaper\.(jpg|png)")
  local wallpaper_path="$BASE/$current_theme/$wall_located"

  swww img --transition-type wipe \
           --transition-angle 30 \
           --transition-step 255 \
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
