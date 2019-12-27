#!/usr/bin/sh

# Ensure theme and variant exist
SWAY_THEME="$THEME_DIR/sway/$THEME-$VARIANT.cfg"
if [ -z "$SWAY_THEME" ]; then
   echo "No $THEME $VARIANT theme found for sway"
   exit 1
fi

# Get config directory
if [ -n "$XDG_CONFIG_HOME" ]; then
    SWAY_CONFIG_DIR=$XDG_CONFIG_HOME/sway
else
    SWAY_CONFIG_DIR=$HOME/.config/sway
fi

# Ensure sway config.d directory exists
SWAY_CONFIG_DIR="$SWAY_CONFIG_DIR/config.d"
mkdir -p "$SWAY_CONFIG_DIR"

# Add active theme to sway config
ln -sf "$SWAY_THEME" "$SWAY_CONFIG_DIR/theme.cfg"

# Reload config
swaymsg reload
