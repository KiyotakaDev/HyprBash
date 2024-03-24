# Hyprbash

Welcome to Hyprbash repository, here you'll find my personal configuration for Hyprand tiling compositor :D

## Installation


```bash
# Clone this repo in ~ path
git clone https://github.com/KiyotakaDev/HyprBash.git

# Go to installation script
cd Hyprbash/.scripts

# Give permissions to installer script
chmod +x install_me.sh

# Execute script
./install_me.sh

# If you want custom packages see next step ->
```

## Options

> [!NOTE]
> install_me.sh can recieve a file with desired packages to install
> (Others than default packages on install_me.sh script)

```
# my_apps.txt
neovim
discord
```

Then pass it to the script

```bash
./install_me.sh my_apps.txt
```

## Last step

Serve custom config from Hyprbash config dir

```bash
ln -s ~/Hyprbash/.config ~/.config
```

// TODO: Automatize that line
