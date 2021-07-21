#!/usr/bin/sh

emacsclient -e '(counsel-load-theme-action (my/get-active-theme))' > /dev/null 2>&1
