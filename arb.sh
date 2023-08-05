#!/bin/bash

# Initial Setup
apt install mugshot xfce4-terminal -y
update-alternatives --set x-terminal-emulator /usr/bin/xfce4-terminal.wrapper

# Install themes, icons, cursors, and fonts
mkdir $HOME/.themes
mkdir $HOME/.local/share/icons
mv GTK-XFWM-Theme/Ever* $HOME/.themes
unzip Nordzy-cyan-dark-MOD.zip -d $HOME/.local/share/icons
git clone https://github.com/alvatip/Radioactive-nord.git
cd Radioactive-nord
sudo ./install.sh
cd ..
unzip fonts.zip -d $HOME/.local/share/

# Installing Kvantum theme and fonts
sudo apt install qt5-style-kvantum qt5-style-kvantum-themes -y
cp -r Kvantum $HOME/.config/

# Config LightDM Login Manager
sudo cp -r $HOME/.themes/GTK-XFWM-Everblush-Theme/Everblush /usr/share/themes
sudo cp -Rv $HOME/.local/share/icons/Nordzy-cyan-dark-MOD /usr/share/icons
sudo mv  lightdm-gtk-greeter.conf /etc/lightdm/lightdm-gtk-greeter.conf

# Installing and Config Picom
sudo apt install libxext-dev libxcb1-dev libxcb-damage0-dev libxcb-xfixes0-dev libxcb-shape0-dev libxcb-render-util0-dev libxcb-render0-dev libxcb-randr0-dev libxcb-composite0-dev libxcb-image0-dev libxcb-present-dev libxcb-xinerama0-dev libxcb-glx0-dev libpixman-1-dev libdbus-1-dev libconfig-dev libgl1-mesa-dev libpcre2-dev libpcre3-dev libevdev-dev uthash-dev libev-dev libx11-xcb-dev meson -y
sudo apt install picom -y
cp picom-config/picom.conf $HOME/.config
sudo xfconf-query -c xfwm4 -p /general/use_compositing -t bool -s false

# Configure xfce4-panel and dock-like plugin
## Panel
cp -r home-config/.assets $HOME/
mv $HOME/.profile $HOME/.profile.old
cp home-config/.profile $HOME/
cp home-config/.Xresources $HOME/
cp gtk.css $HOME/.config/gtk-3.0
cp -r genmon-scripts $HOME
mv $HOME/.config/xfce4 $HOME/.config/xfce4.old
cp -r xfce4 $HOME/.config/


## Dock-like Plugin
sudo apt install xfce4-dev-tools libstartup-notification0-dev libwnck-3-dev libxfce4ui-2-dev libxfce4panel-2.0-dev -y
git clone https://gitlab.xfce.org/panel-plugins/xfce4-docklike-plugin.git
cd xfce4-docklike-plugin
sudo ./autogen.sh --prefix=/usr/local
sudo make
sudo make install
sudo cp src/docklike.desktop /usr/share/xfce4/panel/plugins
sudo cp src/.libs/libdocklike.so /usr/lib/x86_64-linux-gnu/xfce4/panel/plugins/
sudo cp src/libdocklike.la /usr/lib/x86_64-linux-gnu/xfce4/panel/plugins

# Installing and Configuring Findex
sudo apt install libkeybinder-3.0-dev cargo -y
git clone https://github.com/mdgaziur/findex.git
cd findex
sudo ./installer.sh

# Installing Lock Screen
sudo apt install i3lock-color -y
sudo xfconf-query --create -c xfce4 session -p /general/LockCommand -t string -s "i3lock-everblush"
sudo cp i3lock-color-everblush/i3lock-everblush /usr/bin

echo "REBOOT me please" 






