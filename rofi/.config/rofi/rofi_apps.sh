#!/usr/bin/env bash
# ─────────────────────────────────────────────
#  rofi_apps.sh — Application (UPDATES ON USAGE)
#  These are in Grid View
# ─────────────────────────────────────────────

SCRIPTS_DIR="$(dirname "$(realpath "$0")")"
THEME="$SCRIPTS_DIR/drun-theme.rasi"

rofi -show drun \
	-show-icons \
	-drun-display-format "{name}" \
	-theme "$THEME" 2>/dev/null
