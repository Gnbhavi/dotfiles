#!/usr/bin/env bash
# ─────────────────────────────────────────────
#  rofi-hub.sh — Main Launcher Hub
#  Bind this to Meta+Space in KDE Settings
# ─────────────────────────────────────────────

SCRIPTS_DIR="$(dirname "$(realpath "$0")")"
THEME="$SCRIPTS_DIR/hub-theme.rasi"
# THEME="$HOME/.config/rofi/hub-theme.rasi"

# ── 4 hub entries: ICON  LABEL  (tab-separated, rofi reads them) ──
OPTIONS="󰀻  Applications\n󰱼  File Search\n󰖩  System\n󰃬  Calculator"

CHOSEN=$(
	printf "%b" "$OPTIONS" | rofi \
		-dmenu \
		-i \
		-p "  Launch" \
		-no-custom \
		-theme "$THEME" \
		-theme-str 'window {width : 480 px;} listview {lines: 4; }'
)

# ── Route to the right script ──
case "$CHOSEN" in
*"Applications"*)
	"$SCRIPTS_DIR/rofi_apps.sh"
	# rofi -show drun \
	# 	-theme "$THEME" \
	# 	-theme-str '
	#        window { width: 480px; }
	#        listview { lines: 4; }
	#      '
	;;
*"File Search"*)
	"$SCRIPTS_DIR/rofi_files.sh"
	;;
*"System"*)
	"$SCRIPTS_DIR/rofi_system.sh"
	;;
*"Calculator"*)
	"$SCRIPTS_DIR/rofi_calc.sh"
	;;
esac
