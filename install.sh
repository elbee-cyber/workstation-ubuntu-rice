#!/bin/bash
# Polybar themes: https://github.com/adi1090x/polybar-themes (alot was taken from here)

echo "Installing packages..."
echo 'deb http://archive.debian.org/debian-security stretch/updates main contrib non-free
' | sudo tee -a /etc/apt/sources.list.d/backports.list
sudo apt update
# Apps and base system
sudo apt install polybar i3 rofi zsh python3-pip curl autoconf build-essential git stow tmux tree vim-nox picom -y
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

echo "You will be prompted to generate i3 config, press return"
i3-config-wizard

echo "Backing up i3 config..."
mkdir -p ~/.config/i3/backup
cp -rf ~/.config/i3/config ~/.config/i3/backup/config.bak

echo "Configuring alacritty..."
sudo alacritty migrate
sudo chown `whoami`:`whoami` /etc/xdg/alacritty/alacritty.toml
echo "set \$term alacritty" >>~/.config/i3/config
sed -i -E 's|(^\s*bindsym\s+\$mod\+Return\s+exec\s+).*|\1alacritty|' ~/.config/i3/config

echo "Configuring picom borders..."
mkdir -p ~/.config/picom
cp -rf config/picom/* ~/.config/picom
echo "picom --config ~/.config/picom/picom.conf &" >>~/.config/i3/config

echo "Adding gaps to i3..."
echo "gaps inner 15" >>~/.config/i3/config
echo "gaps outer 15" >>~/.config/i3/config
echo "smart_borders on" >>~/.config/i3/config

echo "Setting wallpaper..."
mkdir -p ~/.config/wallpapers
cp dark-sky.jpg ~/.config/wallpapers
echo "wal -i ~/.config/wallpapers/dark-sky.jpg" >>~/.config/i3/config

echo "Configuring polybar..."
mkdir -p ~/.config/polybar/colorblocks
cp -rf config/polybar/* ~/.config/polybar/colorblocks
chmod +x ~/.config/polybar/colorblocks/launch.sh
echo "exec_always --no-startup-id ~/.config/polybar/launch.sh" >>~/.config/i3/config
