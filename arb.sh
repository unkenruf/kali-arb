#!/bin/bash

if ! [ $(id -u) = 0 ]; then
	echo "The script needs to be run as root." >&2
	exit 1
fi

if [ $SUDO_USER ]; then
	real_user=$SUDO_USER
else
	real_user=$(whoami)
fi

# Initial Setup
apt install mugshot xfce4-terminal -y
update-alternatives --set x-terminal-emulator /usr/bin/xfce4-terminal.wrapper

# Install themes, icons, cursors, and fonts
sudo -u $real_user mkdir $HOME/.themes
sudo -u $real_user mkdir $HOME/.local/share/icons
sudo -u $real_user mv GTK-XFWM-Theme/Ever* $HOME/.themes
sudo -u $real_user unzip Nordzy-cyan-dark-MOD.zip 
sudo -u $real_user cp -r Nordzy-cyan-dark-MOD $HOME/.local/share/icons
sudo -u $real_user git clone https://github.com/alvatip/Radioactive-nord.git
sudo -u $real_user cd Radioactive-nord
./install.sh
cd ..
sudo -u $real_user unzip fonts.zip -d $HOME/.local/share/

# Installing Kvantum theme and fonts
apt install qt5-style-kvantum qt5-style-kvantum-themes -y
sudo -u $real_user cp -r Kvantum $HOME/.config/

# Config LightDM Login Manager
cp -r GTK-XFWM-Everblush-Theme/Everblush /usr/share/themes
cp -Rv Nordzy-cyan-dark-MOD /usr/share/icons
cp lightdm-gtk-greeter.conf /etc/lightdm/lightdm-gtk-greeter.conf

# Installing and Config Picom
apt install libxext-dev libxcb1-dev libxcb-damage0-dev libxcb-xfixes0-dev libxcb-shape0-dev libxcb-render-util0-dev libxcb-render0-dev libxcb-randr0-dev libxcb-composite0-dev libxcb-image0-dev libxcb-present-dev libxcb-xinerama0-dev libxcb-glx0-dev libpixman-1-dev libdbus-1-dev libconfig-dev libgl1-mesa-dev libpcre2-dev libpcre3-dev libevdev-dev uthash-dev libev-dev libx11-xcb-dev meson -y
apt install picom -y
sudo -u $real_user picom-config/picom.conf $HOME/.config
xfconf-query -c xfwm4 -p /general/use_compositing -t bool -s false

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
apt install xfce4-dev-tools libstartup-notification0-dev libwnck-3-dev libxfce4ui-2-dev libxfce4panel-2.0-dev -y
git clone https://gitlab.xfce.org/panel-plugins/xfce4-docklike-plugin.git
cd xfce4-docklike-plugin
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

# Installing Lock Screen
apt install i3lock-color -y
xfconf-query --create -c xfce4 session -p /general/LockCommand -t string -s "i3lock-everblush"
cp i3lock-color-everblush/i3lock-everblush /usr/bin

echo "REBOOT me please" 






