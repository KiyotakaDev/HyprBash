# Path
src_path=`dirname "$(dirname "$(realpath "$0")")"`
theme_path="${src_path}/swww"
conf_file="${theme_path}/.wallpaper_values.conf"

# Themes
themes=("anime" "neon" "lands")

# Sourcing file
if [ ! -f $conf_file ]; then
  echo "saved_theme=0" > $conf_file
  echo "saved_wallpaper=0" >> $conf_file
  source $conf_file
else
  source $conf_file
fi

# Source variables
curr_theme=$saved_theme
curr_wallpaper=$saved_wallpaper

# Variables
theme="${themes[$curr_theme]}"
wallpapers=("$theme_path/$theme"/*)
wallpaper=${wallpapers[$curr_wallpaper]}
quantity=${#wallpapers[@]}

echo $wallpaper
echo $quantity


# Functions
save_values() {
  echo "saved_theme=$curr_theme" > $conf_file
  echo "saved_wallpaper=$curr_wallpaper" >> $conf_file
}

show_wallpaper() {
  local t_type=${1:-"grow"}

  swww img --transition-type $t_type \
  --transition-pos 0.5,0.5 \
  --transition-step 90 \
  $wallpaper 
}

next_wallpaper() {
  if [ $curr_wallpaper -lt $((quantity - 1)) ]; then
    ((curr_wallpaper++))
  else
    curr_wallpaper=0
  fi
  show_wallpaper
}

prev_wallpaper() {
  if [ $curr_wallpaper -gt 0 ]; then
    ((curr_wallpaper--))
  else
    curr_wallpaper=$((quantity - 1))
  fi
  show_wallpaper "outer"
}

while getopts "np" opt; do
  case $opt in
    n) next_wallpaper;;
    p) prev_wallpaper;;
    *) echo "n: Next wallpaper"
       echo "p: Previous wallpaper"
       exit 1;;
  esac
done

save_values
