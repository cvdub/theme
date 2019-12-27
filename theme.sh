#!/usr/bin/sh

USAGE="usage: theme [OPTION] [THEME] [VARIANT]
Update the theme for enabled applications. Toggle between the default
and alternate theme if THEME is not given.

    -h, --help       show this usage display
"
# Check parameters
if [ $# -gt 2 ]; then
    printf "$USAGE"
    exit 1
fi

if [ "$1" = "-h" ] || [ "$1" = "--help" ]; then
    printf "$USAGE"
    exit 0
fi

# Get active theme dir
if [ -n "$XDG_DATA_HOME" ]; then
    ACTIVE_THEME_DIR=$XDG_DATA_HOME/theme
else
    ACTIVE_THEME_DIR=$HOME/.local/share/theme
fi

ACTIVE_THEME_FILE=$ACTIVE_THEME_DIR/active-theme

# Get active theme
if [ -f "$ACTIVE_THEME_FILE" ]; then
    ACTIVE_THEME=$(awk '{print $1; exit;}' $ACTIVE_THEME_FILE)
    ACTIVE_VARIANT=$(awk '{print $2; exit;}' $ACTIVE_THEME_FILE)
else
    ACTIVE_THEME=""
    ACTIVE_VARIANT=""
fi

# Get config file
if [ -n "$XDG_CONFIG_HOME" ]; then
    CONFIG_FILE=$XDG_CONFIG_HOME/theme/config
else
    CONFIG_FILE=$HOME/.config/theme/config
fi

# Get default and alternate themes
if [ -n "$CONFIG_FILE" ]; then
    DEFAULT_THEME=$(awk '$1=="default" {print $2; exit;}' $CONFIG_FILE)
    DEFAULT_VARIANT=$(awk '$1=="default" {print $3; exit;}' $CONFIG_FILE)
    ALTERNATE_THEME=$(awk '$1=="alternate" {print $2; exit;}' $CONFIG_FILE)
    ALTERNATE_VARIANT=$(awk '$1=="alternate" {print $3; exit;}' $CONFIG_FILE)
else
    DEFAULT_THEME=""
    DEFAULT_VARIANT=""
    ALTERNATE_THEME=""
    ALTERNATE_VARIANT=""
fi

if [ -z "$DEFAULT_THEME" ]; then
    echo "No default theme defined"
    exit 1
fi

if [ -z "$ALTERNATE_THEME" ]; then
    echo "No alternate theme defined"
    exit 1
fi

# Get theme to activate
if [ "$#" -eq 0 ]; then
    if [ "$ACTIVE_THEME" = "$DEFAULT_THEME" ] && \
           [ "$ACTIVE_VARIANT" = "$DEFAULT_VARIANT" ]; then
        THEME=$ALTERNATE_THEME
        VARIANT=$ALTERNATE_VARIANT
    else
        THEME=$DEFAULT_THEME
        VARIANT=$DEFAULT_VARIANT
    fi
else
    THEME=$1
    if [ "$#" -eq 2 ]; then
        VARIANT=$2
    else
        VARIANT=""
    fi
fi

# Get script location
SCRIPT=$(readlink -f $0)
SCRIPT_PATH=$(dirname $SCRIPT)
THEME_DIR=$SCRIPT_PATH/themes/$THEME

# Ensure theme exists
if [ ! -d $THEME_DIR ]; then
    echo "Theme \"$THEME\" not found"
    exit 1
fi

# Ensure theme dir exists
mkdir -p "$ACTIVE_THEME_DIR"

# Save active theme
echo "$THEME" "$VARIANT" > $ACTIVE_THEME_FILE

# Activate theme
for script in $SCRIPT_PATH/scripts/*.sh; do
    source $script $THEME $VARIANT
done
