#!/bin/bash

# Installation script ^u^

# Importing installer functions
source installer_fns.sh

cat <<  EOF 

////////////////////////////////////////
//                                    //
//  ░█░█░█░█░█▀█░█▀▄░█▀▄░█▀█░█▀▀░█░█  //
//  ░█▀█░░█░░█▀▀░█▀▄░█▀▄░█▀█░▀▀█░█▀█  //
//  ░▀░▀░░▀░░▀░░░▀░▀░▀▀░░▀░▀░▀▀▀░▀░▀  //
//                                    //
////////////////////////////////////////

EOF

cat << EOF

          ░█▀▀░▀█▀░█▀▄░█▀▀░▀█▀
          ░█▀▀░░█░░█▀▄░▀▀█░░█░
          ░▀░░░▀▀▀░▀░▀░▀▀▀░░▀░
  ░█▀▀░▀█▀░█▀▀░█▀█░█▀▀        
  ░▀▀█░░█░░█▀▀░█▀▀░▀▀█        
  ░▀▀▀░░▀░░▀▀▀░▀░░░▀▀▀        

EOF

#./first_steps.sh

# User file input
cstm_pkgs=$1
# Preparing packages to install file
cp def_hyprbsh_pkgs.txt pkgs_to_install.txt

# If custm var is a regular file and is not empty; then
if [ -f "$cstm_pkgs" ] && [ -n "$cstm_pkgs" ]; then
  cat $cstm_pkgs >> pkgs_to_install.txt
fi

# Adding shell to list
# If zsh and fish ar not installed; then
if ! is_pkg_installed zsh && ! is_pkg_installed fish; then
  echo -e "Select shell:\n1) zsh\n2) fish"
  read -p "Enter number: " usrinp

  case $usrinp in
    1) shelly="zsh";;
    2) shelly="fish";;
    *) echo -e "Invalid option"
       exit 1;;
   esac
   echo "$shelly" >> pkgs_to_install.txt
fi
