# Path
srcPth=`dirname "$(dirname "$(realpath "$0")")"`
thmPth="${srcPth}/swww"
cfg_fl="${thmPth}/.wallpaper_values.conf"

# Themes
themes=("anime" "neon" "lands")

# Sourcing file
if [ ! -f $cfg_fl ]; then
  echo "saved_theme=0" > $cfg_fl
  echo "saved_wallpaper=0" >> $cfg_fl
  source $cfg_fl
else
  source $cfg_fl
fi

# Source variables
crrnt_thm=$saved_theme
crrnt_wllppr=$saved_wallpaper

# Variables
theme="${themes[$crrnt_thm]}"
wallpapers=("$thmPth/$theme"/*)
wallpaper=${wallpapers[$crrnt_thm]}
quantity=${#wallpapers[@]}

# Functions
save_values() {
  echo "saved_theme=$crrnt_thm" > $cfg_fl
  echo "saved_wallpaper=$crrnt_wllppr" >> $cfg_fl
}

show_wallpaper() {
  local t_type=${1:-"grow"}

  swww img --transition-type $t_type \
  --transition-pos 0.5,0.5 \
  --transition-step 90 \
  $wallpaper 
}

next_wallpaper() {
  if [ $crrnt_wllppr -le $((quantity - 1)) ]; then
    ((crrnt_wllppr++))
  else
    crrnt_wllppr=0
  fi
  show_wallpaper
}

prev_wallpaper() {
  if [ $crrnt_wllppr -gt 0 ]; then
    ((crrnt_wllppr--))
[kiyota@mirai .scripts]$ cat < wallpaper.sh 
# Path
srcPth=`dirname "$(dirname "$(realpath "$0")")"`
thmPth="${srcPth}/swww"
cfg_fl="${thmPth}/.wallpaper_values.conf"

# Themes
themes=("anime" "neon" "lands")

# Sourcing file
if [ ! -f $cfg_fl ]; then
  echo "saved_theme=0" > $cfg_fl
  echo "saved_wallpaper=0" >> $cfg_fl
  source $cfg_fl
else
  source $cfg_fl
fi

# Source variables
crrnt_thm=$saved_theme
crrnt_wllppr=$saved_wallpaper

# Variables
theme="${themes[$crrnt_thm]}"
wallpapers=("$thmPth/$theme"/*)
wallpaper=${wallpapers[$crrnt_wllppr]}
quantity=${#wallpapers[@]}

echo $wallpaper
echo $quantity


# Functions
save_values() {
  echo "saved_theme=$crrnt_thm" > $cfg_fl
  echo "saved_wallpaper=$crrnt_wllppr" >> $cfg_fl
}

show_wallpaper() {
  local t_type=${1:-"grow"}

  swww img --transition-type $t_type \
  --transition-pos 0.5,0.5 \
  --transition-step 90 \
  $wallpaper 
}

next_wallpaper() {
  if [ $crrnt_wllppr -lt $((quantity - 1)) ]; then
    ((crrnt_wllppr++))
  else
    crrnt_wllppr=0
  fi
  show_wallpaper
}

prev_wallpaper() {
  if [ $crrnt_wllppr -gt 0 ]; then
    ((crrnt_wllppr--))
  else
    crrnt_wllppr=$((quantity - 1))
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
