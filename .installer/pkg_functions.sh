is_pkg_installed() {
  local pkg_to_check=$1

  if pacman -Qq "$pkg_to_check" &> /dev/null; then
    return 0 # Installed
  else
    return 1 # Not installed
  fi
}

is_arch_available() {
  local pkg_to_check=$1

  if pacman -Ss "$pkg_to_check" &> /dev/null; then
    return 0 # On arch repo
  else
    return 1 # Not on arch repo
  fi
}

yay_installer() {
  if ! is_pkg_installed "git"; then
    echo "PKG git must be installed"
  else
    echo "Not installed"
  fi
}
