#!/usr/bin/sh

emacsclient -e '(cjv-load-active-theme)' > /dev/null 2>&1

DOOM_THEME=doom-"$THEME"
if [ "$VARIANT" = "light" ]; then
    DOOM_THEME="$DOOM_THEME"-light
fi
emacsclient -q -s doom -e "(counsel-load-theme-action \"$DOOM_THEME\")" 
