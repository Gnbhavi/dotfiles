#!/usr/bin/env bash
# ─────────────────────────────────────────────
#  rofi-system.sh — WiFi / Bluetooth / Settings
# ─────────────────────────────────────────────
SCRIPTS_DIR="$(dirname "$(realpath "$0")")"
SCRIPTS_DIR="$(dirname "$(realpath "$0")")"
THEME="$SCRIPTS_DIR/hub-theme.rasi"

_wifi_menu() {
	# 1. Check if WiFi is actually on
	WIFI_STATUS=$(nmcli radio wifi)

	if [ "$WIFI_STATUS" != "enabled" ]; then
		CONFIRM=$(printf "󰤨  Turn WiFi ON\n󰅙  Cancel" | rofi \
			-dmenu -i -p "󰤮  WiFi is OFF" -no-custom \
			-theme "$THEME" \
			-theme-str 'window { width: 400px; } listview { lines: 2; }')
		[[ "$CONFIRM" == *"Turn WiFi ON"* ]] || return

		nmcli radio wifi on
		sleep 2 # Let the hardware wake up
	fi

	# 2. The Clean Intermediate Menu (Matches Bluetooth style!)
	WIFI_MENU_OPTS="󰑐  Scan & Connect\n󰤮  Turn WiFi OFF"

	CHOSEN_WIFI_MENU=$(printf "%b" "$WIFI_MENU_OPTS" | rofi \
		-dmenu -i -p "󰖩  WiFi" -no-custom \
		-theme "$THEME" \
		-theme-str 'window { width: 400px; } listview { lines: 2; }')

	case "$CHOSEN_WIFI_MENU" in
	*"Turn WiFi OFF"*)
		nmcli radio wifi off
		notify-send "WiFi" "Turned OFF" --icon=network-wireless-offline
		return
		;;
	*"Scan & Connect"*)
		#Send a quick, temporary notification so you know it didn't freeze!
		notify-send "WiFi" "Scanning airwaves..." --icon=network-wireless-acquiring -t 2000

		# 3. Now we fetch the networks and show the list!
		RAW_WIFI=$(nmcli -t -f BARS,SSID dev wifi list | awk -F: '$2 != "" && !seen[$2]++ {print $1 "  " $2}')

		CHOSEN_NET=$(printf "%s" "$RAW_WIFI" | rofi \
			-dmenu -i -p "󰤨  Select Network" -no-custom \
			-theme "$THEME" \
			-theme-str 'window { width: 450px; } listview { lines: 8; }')

		[ -z "$CHOSEN_NET" ] && return

		# Extract the SSID
		SSID=$(echo "$CHOSEN_NET" | awk '{$1=""; print substr($0,2)}')
		SAVED_CONNECTIONS=$(nmcli -g NAME connection)

		# 4. Connection Logic
		if echo "$SAVED_CONNECTIONS" | grep -q "^$SSID$"; then
			notify-send "WiFi" "Connecting to $SSID..." --icon=network-wireless
			if nmcli connection up id "$SSID" >/dev/null 2>&1; then
				notify-send "WiFi" "Connected to $SSID ✓" --icon=network-wireless-connected
			else
				notify-send "WiFi" "Failed to connect to $SSID" --icon=dialog-error
			fi
		else
			SECURED=$(nmcli -t -f SSID,SECURITY dev wifi list | grep "^$SSID:" | awk -F: '{print $2}' | head -n 1)

			if [ "$SECURED" = "" ] || [ "$SECURED" = "--" ]; then
				notify-send "WiFi" "Connecting to open network $SSID..."
				if nmcli dev wifi connect "$SSID" >/dev/null 2>&1; then
					notify-send "WiFi" "Connected to $SSID ✓"
				else
					notify-send "WiFi" "Failed to connect" --icon=dialog-error
				fi
			else
				# We use -mesg to put the network name on top
				# We force the 'message' box to show up above the 'inputbar'
				WIFI_PASS=$(rofi -dmenu -password -p "󰌾 " \
					-mesg "Network: <b>$SSID</b>" \
					-theme "$THEME" \
					-theme-str '
                            mainbox { children: [ message, inputbar ]; } 
                            message { background-color: @bg1; border-radius: 8px; padding: 10px; margin: 0px 0px 10px 0px; }
                            window { width: 400px; } 
                            listview { lines: 0; }
                        ')

				[ -z "$WIFI_PASS" ] && return

				notify-send "WiFi" "Connecting to $SSID..."
				if nmcli dev wifi connect "$SSID" password "$WIFI_PASS" >/dev/null 2>&1; then
					notify-send "WiFi" "Connected to $SSID ✓"
				else
					notify-send "WiFi" "Failed to connect. Wrong password?" --icon=dialog-error
				fi
			fi
		fi
		;;
	esac
}
_bluetooth_menu() {
	BT_STATUS=$(bluetoothctl show | grep "Powered:" | awk '{print $2}')

	if [ "$BT_STATUS" != "yes" ]; then
		CONFIRM=$(printf "󰂯  Turn Bluetooth ON\n󰅙  Cancel" | rofi \
			-dmenu -i -p "󰂲  Bluetooth is OFF" -no-custom \
			-theme "$THEME" \
			-theme-str 'window { width: 400px; } listview { lines: 2; }')
		[[ "$CONFIRM" == *"Turn Bluetooth ON"* ]] || return
		bluetoothctl power on
		sleep 1
	fi

	BT_OPTIONS="󰂱  Scan & Pair new device\n󰂰  Open Blueman (full manager)\n󰂲  Turn Bluetooth OFF"

	BT_CHOSEN=$(printf "%b" "$BT_OPTIONS" | rofi \
		-dmenu -i -p "󰂯  Bluetooth" -no-custom \
		-theme "$THEME" \
		-theme-str 'window { width: 460px; } listview { lines: 3; }')

	case "$BT_CHOSEN" in
	*"Scan & Pair"*)
		notify-send "Bluetooth" "Scanning for devices..." --icon=bluetooth
		bluetoothctl --timeout 8 scan on 2>/dev/null
		# Get devices and strip ALL ANSI escape sequences + control chars
		DEVICES=$(bluetoothctl devices 2>/dev/null |
			sed 's/^Device //' |
			sed -E 's/\x1B\[[0-9;]*[a-zA-Z]//g' |
			sed 's/\x0//g' |
			tr -d '\000-\037\177') # remove all control characters
		if [ -z "$DEVICES" ]; then
			notify-send "Bluetooth" "No devices found nearby" --icon=dialog-warning
			return
		fi

		DEVICE_CHOSEN=$(printf "%s\n" "$DEVICES" | rofi \
			-dmenu -i -p "󰂱  Pick device" \
			-theme "$THEME" \
			-theme-str 'window { width: 560px; } listview { lines: 8; }')

		[ -z "$DEVICE_CHOSEN" ] && return

		MAC=$(echo "$DEVICE_CHOSEN" | awk '{print $1}')
		NAME=$(echo "$DEVICE_CHOSEN" | cut -d' ' -f2-)

		notify-send "Bluetooth" "Pairing with $NAME..." --icon=bluetooth
		bluetoothctl pair "$MAC" &&
			bluetoothctl connect "$MAC" &&
			bluetoothctl trust "$MAC" &&
			notify-send "Bluetooth" "Connected to $NAME ✓" --icon=bluetooth ||
			notify-send "Bluetooth" "Failed to pair with $NAME" --icon=dialog-error
		;;
	*"Blueman"*)
		blueman-manager &
		;;
	*"Turn Bluetooth OFF"*)
		bluetoothctl power off
		notify-send "Bluetooth" "Turned OFF" --icon=bluetooth-disabled
		;;
	esac
}

# _power_menu() {
# 	POWER_OPTIONS="󰤄  Suspend\n󰑓  Reboot\n󰐥  Shutdown\n󰍃  Logout"
# 	POWER_CHOSEN=$(printf "%b" "$POWER_OPTIONS" | rofi \
# 		-dmenu -i -p "󰐥  Power" -no-custom \
# 		-theme "$THEME" \
# 		-theme-str 'window { width: 380px; } listview { lines: 4; }')
#
# 	case "$POWER_CHOSEN" in
# 	*"Suspend"*) systemctl suspend ;;
# 	*"Reboot"*) systemctl reboot ;;
# 	*"Shutdown"*) systemctl poweroff ;;
# 	*"Logout"*) loginctl terminate-user "$USER" ;;
# 	esac
# }

# ── Main menu ──

OPTIONS="󰤨  WiFi — Connect / Manage\n󰂯  Bluetooth — Toggle & Pair\n󰒓  System Settings\n󰌾  Lock Screen\n󰤄  Toggle Do Not Disturb\n󰐥  Power Menu"

CHOSEN=$(printf "%b" "$OPTIONS" | rofi \
	-dmenu -i -p "󰖩  System" -no-custom \
	-theme "$THEME" \
	-theme-str 'window { width: 500px; } listview { lines: 6; }')

case "$CHOSEN" in
*"WiFi"*)
	# kitty --title "WiFi Manager" -- nmtui &
	_wifi_menu
	;;
*"Bluetooth"*)
	_bluetooth_menu
	;;
*"System Settings"*)
	systemsettings 2>/dev/null &
	;;
*"Lock Screen"*)
	loginctl lock-session
	;;
*"Do Not Disturb"*)
	qdbus org.kde.plasmashell /org/kde/osdService org.kde.osdService.inhibitNotifications 2>/dev/null
	notify-send "Do Not Disturb" "Toggled"
	;;
*"Power Menu"*)
	"$SCRIPTS_DIR/power_menu.sh"
	;;
esac
