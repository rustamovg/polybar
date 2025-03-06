#!/bin/bash

# Get available Wi-Fi networks
wifi_list=$(nmcli -f SSID,SIGNAL dev wifi | tail -n +2 | awk '{print $1 " (" $2 "%)"}')

# Add extra options
wifi_list="Refresh\nDisconnect\n$wifi_list"

# Show menu using Rofi
chosen=$(echo -e "$wifi_list" | rofi -dmenu -p "Wi-Fi Networks")

# Actions
if [[ "$chosen" == "Refresh" ]]; then
    nmcli dev wifi rescan
elif [[ "$chosen" == "Disconnect" ]]; then
    nmcli con down $(nmcli -t -f NAME con show --active)
elif [[ -n "$chosen" ]]; then
    ssid=$(echo "$chosen" | awk -F' (' '{print $1}')
    password=$(rofi -dmenu -p "Enter Wi-Fi Password" -password)
    nmcli dev wifi connect "$ssid" password "$password"
fi
