#!/bin/bash

# Initial Setup
apt install mugshot xfce4-terminal -y
update-alternatives --set x-terminal-emulator /usr/bin/xfce4-terminal.wrapper

# Install themes, icons, cursors, and fonts
mkdir ~/.themes
mkdir ~/.local/share/icons
unzip GTK-XFWM-Theme.zip 
mv GTK-XFWM-Theme/Ever* ~/.themes
unzip Nordzy-cyan-dark-MOD.zip -d ~/.local/share/icons
git clone https://github.com/alvatip/Radioactive-nord.git
cd Radioactive-nord
./install.sh
cd ..
unzip fonts.zip -d ~/.local/share/

# Installing Kvantum theme and fonts
apt install qt5-style-kvantum qt5-style-kvantum-themes -y
unzip Kvantum-theme.zip -d ~/.config/

# Config LightDM Login Manager
cp -r ~/.themes/GTK-XFWM-Everblush-Theme/Everblush /usr/share/themes
cp -Rv ~/.local/share/icons/Nordzy-cyan-dark-MOD /usr/share/icons
mv  lightdm-gtk-greeter.conf /etc/lightdm/lightdm-gtk-greeter.conf

# Installing and Config Picom
apt install libxext-dev libxcb1-dev libxcb-damage0-dev libxcb-xfixes0-dev libxcb-shape0-dev libxcb-render-util0-dev libxcb-render0-dev libxcb-randr0-dev libxcb-composite0-dev libxcb-image0-dev libxcb-present-dev libxcb-xinerama0-dev libxcb-glx0-dev libpixman-1-dev libdbus-1-dev libconfig-dev libgl1-mesa-dev libpcre2-dev libpcre3-dev libevdev-dev uthash-dev libev-dev libx11-xcb-dev meson -y
apt install picom -y
unzip picom-config.zip
mv picom-config/picom.conf ~/.config
rm -r picom-config
xfconf-query -c xfwm4 -p /general/use_compositing -t bool -s false

# Configure xfce4-panel and dock-like plugin
## Panel
xfce4-panel --quit
pkill xfconfd
unzip home-config.zip
cp -r .assets ~/
mv ~/.profile ~/.profile.old
cp home-config/.profile ~/
cp home-config/.Xresources ~/
unzip gtk-3.0
mv gtk-3.0/gtk.css ~/.config/gtk-3.0
unzip xfce4-config.zip
cp -r genmon-scripts
mv ~/.config/xfce4 ~/.config/xfce4.old
cp -r xfce4 ~/.config/
sed -i "s/kali/$USER/g" ~/.config/xfce4/panel/genmon*
sed -i "s/kali/$USER/g" ~/.config/xfce4/panel/whisker*
sed -i "s/kali/$USER/g" ~/.config/xfce4/panel/launcher-1/*
xfce4-panel &

## Dock-like Plugin
apt install xfce4-dev-tools libstartup-notification0-dev libwnck-3-dev libxfce4ui-2-dev libxfce4panel-2.0-dev -y
git clone https://gitlab.xfce.org/panel-plugins/xfce4-docklike-plugin.git && cd xfce4-docklike-plugin
./autogen.sh --prefix=/usr/local
make
make install
cp src/docklike.desktop /usr/share/xfce4/panel/plugins
cp src/.libs/libdocklike.so /usr/lib/x86_64-linux-gnu/xfce4/panel/plugins/
cp src/libdocklike.la /usr/lib/x86_64-linux-gnu/xfce4/panel/plugins

# Installing and Configuring Findex
apt install libkeybinder-3.0-dev cargo -y
git clone https://github.com/mdgaziur/findex.git
cd findex
./installer.sh
sed -i 's/Shift/ctrl/g' ~/.config/findex/settings.toml

# Installing Lock Screen
apt install i3lock-color -y
xfconf-query --create -c xfce4 session -p /general/LockCommand -t string -s "i3lock-everblush"
unzip i3lock-color-everblush.zip
mv i3lock-color-everblush/i3lock-everblush /usr/bin

echo "REBOOT me please" 






