# Path
src_path=`dirname "$(dirname "$(realpath "$0")")"`
theme_path="${src_path}/swww"
conf_file="${theme_path}/.wallpaper_values.conf"

# Themes
themes=("deep_green" "neon")

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
theme_quantity=$((${#themes[@]} - 1))
wallpapers=("$theme_path/$theme"/*)
wallpaper=${wallpapers[$curr_wallpaper]}
wallpaper_quantity=$((${#wallpapers[@]} - 1))

# Global functions
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
