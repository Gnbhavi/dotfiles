#!/usr/bin/env bash
# ─────────────────────────────────────────────
#  File Searcher (Streaming + History Auto-Sort)
# ─────────────────────────────────────────────

SCRIPTS_DIR="$(dirname "$(realpath "$0")")"
THEME="$SCRIPTS_DIR/files-theme.rasi"
HISTORY_FILE="$HOME/.cache/rofi_file_history"
touch "$HISTORY_FILE"

# 1. Grab your history from newest to oldest
get_history() {
	# 'tac' reads the file backwards so your most recent clicks are first!
	tac "$HISTORY_FILE" | while read -r file; do
		# Only output it if the file hasn't been deleted from your PC
		[ -f "$file" ] && echo "$file"
	done
}

# 2. Stream the rest of the files normally
get_files() {
	if command -v fd &>/dev/null; then
		fd . "$HOME" --type f --hidden \
			--exclude .git --exclude node_modules --exclude target \
			--exclude .venv --exclude __pycache__ \
			--exclude .cache --exclude .mozilla \
			--exclude .local/share/Trash 2>/dev/null
	else
		find "$HOME" -type f \
			! -path "*/.git/*" ! -path "*/node_modules/*" ! -path "*/target/*" \
			! -path "*/.venv/*" ! -path "*/__pycache__/*" \
			! -path "*/.cache/*" ! -path "*/.mozilla/*" \
			! -path "*/.local/share/Trash/*" 2>/dev/null
	fi
}

# 3. Combine history and new files!
# The '!seen[$0]++' trick ensures your history files don't show up twice.
# 3. Combine history and new files!
CHOSEN=$({
	get_history
	get_files
} | awk -F/ -v home="$HOME" '
!seen[$0]++ {
    path = $0; name = $NF; sub(home, "~", path);
    printf "<b>%s</b>\n<span size=\"small\" color=\"#64a5cd\">%s</span>\x1e", name, path
}' | rofi \
	-dmenu \
	-i \
	-markup-rows \
	-sep $'\x1e' \
	-eh 2 \
	-p "󰱼  File" \
	-mesg "󰍉 <b>Search Tip:</b> <b>Enter</b> opens file | <b>Alt+Enter</b> opens folder" \
	-theme "$THEME" \
	-theme-str 'window { width: 750px; } listview { lines: 6; }' \
	-kb-custom-1 "Alt+Return" 2>/dev/null)

# Capture Rofi's exit code immediately!
# 0 = Standard Enter, 10 = Custom Key 1 (Alt+Enter)
ROFI_EXIT=$?

# 4. Extract the clean path, save to history, and open!
if [[ "$ROFI_EXIT" -eq 0 || "$ROFI_EXIT" -eq 10 ]] && [ -n "$CHOSEN" ]; then
	CLEAN_PATH=$(echo "$CHOSEN" | sed -n 's/.*color="#64a5cd">\(.*\)<\/span>.*/\1/p')
	CLEAN_PATH="${CLEAN_PATH/#\~/$HOME}"

	if [ -n "$CLEAN_PATH" ]; then
		# Append the opened file to the history tracker
		echo "$CLEAN_PATH" >>"$HISTORY_FILE"

		# Keep the history file clean (only save the last 100 clicks)
		tail -n 100 "$HISTORY_FILE" >"$HISTORY_FILE.tmp" && mv "$HISTORY_FILE.tmp" "$HISTORY_FILE"

		if [ "$ROFI_EXIT" -eq 10 ]; then
			# Alt+Enter pressed: Open the folder containing the file
			xdg-open "$(dirname "$CLEAN_PATH")" 2>/dev/null &
		else
			# Standard Enter pressed: Open the file itself
			xdg-open "$CLEAN_PATH" 2>/dev/null &
		fi
	fi
fi
