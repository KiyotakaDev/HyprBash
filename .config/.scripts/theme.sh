#!/bin/bash

# Sourcing global variables
# Executing source global.sh doesn't work
path=`dirname "$(realpath "$0")"`
source "$path/global.sh"

# Functions
print_theme() {
  echo ID: $curr_theme
  echo Theme: $theme
}

next_theme() {
  # print_theme
  if [ $curr_theme -lt $theme_quantity ]; then
    ((curr_theme++))
  else
    curr_theme=0
  fi
}

prev_theme() {
  # print_theme
  if [ $curr_theme -gt 0 ]; then
    ((curr_theme--))
  else
    curr_theme=$((theme_quantity))
  fi
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
