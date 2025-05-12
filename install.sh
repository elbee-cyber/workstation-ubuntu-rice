#!/bin/bash
# Polybar themes: https://github.com/adi1090x/polybar-themes (alot was taken from here)

echo "Installing packages..."
echo 'deb http://archive.debian.org/debian-security stretch/updates main contrib non-free
' | sudo tee -a /etc/apt/sources.list.d/backports.list
sudo apt update
# Apps and base system
sudo apt install polybar i3 feh zsh rofi python3-pip curl alacritty autoconf build-essential git stow tmux tree vim-nox picom -y
sudo pip3 install pywal --break-system-packages

echo "Installing networkmanager-dmenu..."
git clone https://github.com/firecat53/networkmanager-dmenu
sudo cp networkmanager-dmenu/networkmanager_dmenu /usr/local/bin/networkmanager-dmenu
rm ./networkmanager-dmenu -rf

echo "Installing powerlevel10k theme..."
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ~/.config/powerlevel10k
echo 'source ~/.config/powerlevel10k/powerlevel10k.zsh-theme' >>~/.zshrc

# https://github.com/adi1090x/polybar-themes/blob/master/setup.sh
echo "Installing fonts..."
FDIR="$HOME/.local/share/fonts"
[[ ! -d "$FDIR" ]] && mkdir -p "$FDIR"
cp -rf fonts/* "$FDIR"
fc-cache -f -v

echo
echo "You will be prompted to generate i3 config, press return twice" 
echo
sleep 2
i3-config-wizard

echo "Backing up i3 config..."
mkdir -p ~/.config/i3/backup
cp -rf ~/.config/i3/config ~/.config/i3/backup/config.bak

echo "Configuring alacritty..."
sudo alacritty migrate
sudo chown `whoami`:`whoami` /etc/xdg/alacritty/alacritty.toml

echo "Configuring picom borders..."
mkdir -p ~/.config/picom
cp -rf config/picom/* ~/.config/picom

echo "Setting wallpaper..."
mkdir -p ~/.config/wallpapers
cp dark-sky.jpg ~/.config/wallpapers

echo "Configuring polybar..."
mkdir -p ~/.config/polybar/
cp -rf config/polybar/* ~/.config/polybar
chmod +x ~/.config/polybar/launch.sh

cp config/i3/config ~/.config/i3/config
chmod +x ~/.config/polybar/forest/scripts/*.sh

git clone https://github.com/dylanaraps/neofetch
cd neofetch
sudo make install