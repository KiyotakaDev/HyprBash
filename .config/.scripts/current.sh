#!/bin/bash

# Sourcing global variables
# Executing source global.sh doesn't work
path=$(dirname "$(realpath "$0")")
source "$path/global.sh"

# echo Wallpaper: $curr_wallpaper
# echo Theme: $curr_theme

swww query
[ $? -eq 1 ] && sww-daemon


show_wallpaper
