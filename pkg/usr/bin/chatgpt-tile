#!/bin/bash

LAYOUT="$1"
PROFILE_DIR="$HOME/.config/chatgpt-profile"

google-chrome --app=https://chat.openai.com \
    --user-data-dir="$PROFILE_DIR" \
    >/dev/null 2>&1 &

sleep 1.2

WIN_ID=$(wmctrl -lx | grep -i "chat.openai.com" | awk '{print $1}')

if [ -z "$WIN_ID" ]; then
    exit 0
fi

# Tile based on selection
case "$LAYOUT" in
    left)
        wmctrl -ir "$WIN_ID" -e 0,0,0,-1,-1
        ;;
    right)
        # Move to right: -1,-1 means keep maximized height
        SCREEN_W=$(xdpyinfo | awk '/dimensions:/ {print $2}' | cut -d'x' -f1)
        HALF_W=$((SCREEN_W / 2))
        wmctrl -ir "$WIN_ID" -e 0,$HALF_W,0,-1,-1
        ;;
    full)
        wmctrl -ir "$WIN_ID" -b add,maximized_vert,maximized_horz
        ;;
    *)
        echo "Unknown layout. Options: left, right, full"
        ;;
esac
