#!/usr/bin/sh

# Ensure theme and variant exist
WAYBAR_THEME_FILE="$THEME_DIR/waybar/$THEME-$VARIANT.scss"
if [ -z "$WAYBAR_THEME_FILE" ]; then
   echo "No $THEME $VARIANT theme found for Waybar"
   exit 1
fi

# Get config directory
if [ -n "$XDG_CONFIG_HOME" ]; then
    WAYBAR_CONFIG_DIR=$XDG_CONFIG_HOME/waybar
else
    WAYBAR_CONFIG_DIR=~/.config/waybar
fi

# Set theme
sassc "$WAYBAR_THEME_FILE" "$WAYBAR_CONFIG_DIR/style.css"
