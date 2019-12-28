#!/usr/bin/sh

# Ensure theme and variant exist
TERMITE_THEME="$THEME_DIR/termite/$THEME-$VARIANT"
if [ -z "$TERMITE_THEME" ]; then
   echo "No $THEME $VARIANT theme found for termite"
   exit 1
fi

# Get config directory
if [ -n "$XDG_CONFIG_HOME" ]; then
    TERMITE_CONFIG_DIR=$XDG_CONFIG_HOME/termite
else
    TERMITE_CONFIG_DIR=$HOME/.config/termite
fi

# Update theme
cp "$TERMITE_CONFIG_DIR/base-config" "$TERMITE_CONFIG_DIR/config"
cat "$TERMITE_THEME" >> "$TERMITE_CONFIG_DIR/config"

# Reload config
killall -USR1 termite > /dev/null 2>&1
