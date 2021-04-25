#!/usr/bin/sh

# Ensure theme and variant exist
GTK_THEME_FILE="$THEME_DIR/gtk/$THEME-$VARIANT"
if [ -z "$GTK_THEME_FILE" ]; then
   echo "No $THEME $VARIANT theme found for GTK"
   exit 1
fi

GTK_THEME=$(awk '{print $1; exit;}' $GTK_THEME_FILE)

# Get config directory
if [ -n "$XDG_CONFIG_HOME" ]; then
    CONFIG_DIR=$XDG_CONFIG_HOME
else
    CONFIG_DIR=~/.config
fi

GTK4_CONFIG_FILE=$CONFIG_DIR/gtk-4.0/settings.ini
GTK3_CONFIG_FILE=$CONFIG_DIR/gtk-3.0/settings.ini
GTK2_CONFIG_FILE=~/.gtkrc-2.0
QT_CONFIG_FILE=$CONFIG_DIR/qt5ct/qt5ct.conf

gsettings set org.gnome.desktop.interface gtk-theme "$GTK_THEME"
sed -i 's/gtk-theme-name=.*/gtk-theme-name='"$GTK_THEME"'/' "$GTK4_CONFIG_FILE"
sed -i 's/gtk-theme-name=.*/gtk-theme-name='"$GTK_THEME"'/' "$GTK3_CONFIG_FILE"
sed -i 's/gtk-theme-name=.*/gtk-theme-name="'"$GTK_THEME"'"/' "$GTK2_CONFIG_FILE"
sed -i 's/style=.*/style='"$GTK_THEME"'/' $QT_CONFIG_FILE
