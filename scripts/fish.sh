#!/usr/bin/sh

# Ensure theme and variant exist
FISH_THEME="$THEME_DIR/fish/$THEME-$VARIANT.fish"
if [ -z "$FISH_THEME" ]; then
   echo "No $THEME $VARIANT theme found for fish"
   exit 1
fi

# Activate theme
fish "$FISH_THEME"
fish "$THEME_DIR/fish/activate-theme.fish"
