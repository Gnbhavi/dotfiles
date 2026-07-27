#!/bin/bash

# You can source your theme variable here if you have a global config file, 
# or just define it directly.

SCRIPTS_DIR="$(dirname "$(realpath "$0")")"
THEME="$SCRIPTS_DIR/hub-theme.rasi"
# THEME="$HOME/.config/rofi/hub-theme.rasi"

cliphist list | rofi \
    -dmenu \
    -i \
    -p "󰅍  Clipboard" \
    -theme "$THEME" \
    -theme-str 'window {width : 600 px;} listview {lines: 8; }' | cliphist decode | wl-copy

# 2. Automatically press Ctrl+V to paste into your active window!
# (sleep is required so Rofi has time to close before pasting)
sleep 0.2
wtype -M ctrl v -m ctrl
