#!/bin/bash
id=$(xdotool getactivewindow)
app_name=$(xprop -id $id WM_CLASS | awk -F '"' '{print $4}')
echo "$app_name"
