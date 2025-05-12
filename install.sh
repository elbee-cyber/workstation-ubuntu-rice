#!/bin/bash
# Polybar themes: https://github.com/adi1090x/polybar-themes (alot was taken from here)

echo "Installing packages..."
echo "deb http://ftp.debian.org/debian stretch-backports main" > /etc/apt/sources.list.d/backports.list
sudo apt update
# Apps and base system
sudo apt install polybar kitty rofi zsh python3-pip curl python3-pywal autoconf build-essential git stow tmux tree vim-nox
# i3-gaps dependencies
sudo apt install libev-dev libpango1.0-dev libstartup-notification0-dev libxcb-cursor-dev libxcb-icccm4-dev libxcb-keysyms1-dev libxcb-randr0-dev libxcb-util0-dev libxcb-xinerama0-dev libxcb-xkb-dev libxcb-xrm-dev libxcb-xrm0 libxcb1-dev libxkbcommon-dev libxkbcommon-x11-dev libyajl-dev xcb

echo "Installing networkmanager-dmenu..."
git clone https://github.com/firecat53/networkmanager-dmenu
sudo cp ./networkmanager-dmenu/networkmanager-dmenu /usr/local/bin/networkmanager-dmenu
/usr/local/bin/networkmanager-dmenu
rm ./networkmanager-dmenu -rf

echo "Installing i3-radius..."
cd /usr/local/src
git clone https://github.com/Airblader/i3 i3-radius
cd i3-radius
hash=$(git rev-parse --short HEAD)
autoreconf --force --install
mkdir build && cd "$_"
../configure --prefix=/usr/local --sysconfdir=/etc --disable-sanitizers
make PREFIX=/usr/local
make install prefix=/usr/local/stow/i3-radius-$(hash)
find /usr/local/stow/i3-radius-$(hash) -type d -exec chmod 755 {} \;
find /usr/local/stow/i3-radius-$(hash) -type f -exec chmod 644 {} \;
chmod -R 755 /usr/local/stow/i3-radius-$(hash)/bin
cd /usr/local/stow
stow i3-radius-$(hash)
sudo apt install -t stretch-backports feh i3blocks i3lock i3status lightdm sakura suckless-tools xorg

echo "Installing powerlevel10k theme..."
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ~/.config/powerlevel10k
echo 'source ~/.config/powerlevel10k/powerlevel10k.zsh-theme' >>~/.zshrc

# https://github.com/adi1090x/polybar-themes/blob/master/setup.sh
echo "Installing fonts..."
FDIR="$HOME/.local/share/fonts"
[[ ! -d "$FDIR" ]] && mkdir -p "$FDIR"
cp -rf `pwd`/fonts/* "$FDIR"