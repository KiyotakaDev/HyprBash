#!/bin/bash

case "$1" in
  up) 
    pamixer --increase 2 ;;  # Increase volume 2%
  down)
    pamixer --decrease 2 ;;  # Decrease volume 2%
  mute)
    pamixer --toggle-mute ;;
  *)
    echo "Use: $0 (up|down|mute)" ;;
esac
