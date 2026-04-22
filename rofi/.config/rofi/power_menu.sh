#!/usr/bin/env bash
# ─────────────────────────────────────────────
#  Power Menu (Horizontal Style)
# ─────────────────────────────────────────────

# Point this to where you save the new rasi file below
SCRIPTS_DIR="$(dirname "$(realpath "$0")")"
THEME="$SCRIPTS_DIR/powermenu-theme.rasi"

# Get system uptime
UPTIME=$(uptime -p | sed 's/up //')

# Define your entries using Pango markup (using relative sizing for safety)
LOCK="<span size='xx-large'></span>\n<span>Lock</span>"
SHUTDOWN="<span size='xx-large'>󰐥</span>\n<span>Shutdown</span>"
REBOOT="<span size='xx-large'>󰜉</span>\n<span>Reboot</span>"
LOGOUT="<span size='xx-large'>󰍃</span>\n<span>Logout</span>"
SUSPEND="<span size='xx-large'></span>\n<span>Suspend</span>"

# Combine them using the hidden separator \x1e in your requested order!
OPTIONS="$LOCK\x1e$SHUTDOWN\x1e$REBOOT\x1e$LOGOUT\x1e$SUSPEND"

# Run Rofi (-markup-rows enables the sizing, -sep changes the delimiter)
CHOSEN=$(echo -en "$OPTIONS" | rofi \
	-dmenu \
	-i \
	-markup-rows \
	-sep '\x1e' \
	-eh 3 \
	-p "Uptime: $UPTIME" \
	-theme "$THEME" 2>/dev/null)

# Execute based on the selection (using wildcards to ignore the Pango tags)
case "$CHOSEN" in
*"Lock"*) loginctl lock-session ;;
*"Shutdown"*) systemctl poweroff ;;
*"Reboot"*) systemctl reboot ;;
*"Logout"*) loginctl terminate-user "$USER" ;;
*"Suspend"*) systemctl suspend ;;
esac
