#!/usr/bin/env bash
# ─────────────────────────────────────────────
#  rofi-calc.sh — Calculator (LIVE UPDATES)
#  Result is silently copied to clipboard
# ─────────────────────────────────────────────

SCRIPTS_DIR="$(dirname "$(realpath "$0")")"
THEME="$SCRIPTS_DIR/calc-theme.rasi"
ROFI_SIZE='window { width: 520px; } listview { lines: 8; }'

if command -v wl-copy &>/dev/null; then
	COPY_CMD="wl-copy"
elif command -v xclip &>/dev/null; then
	COPY_CMD="xclip -sel clip"
elif command -v xsel &>/dev/null; then
	COPY_CMD="xsel --clipboard --input"
else
	COPY_CMD="cat"
fi

# The '&' at the end of calc-command pushes the copy task to the background.
# This guarantees Rofi closes instantly when you press Enter!
rofi -show calc \
	-modi calc \
	-no-sort \
	-theme "$THEME" \
	-theme-str "$ROFI_SIZE" \
	-calc-command "sh -c 'echo -n \"{result}\" | $COPY_CMD' &" \
	-hint-result "󰃬  " \
	-hint-welcome "Calculate..." 2>/dev/null
