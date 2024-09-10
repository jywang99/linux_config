#!/bin/bash

# initial brightness
echo $(ddcutil getvcp 10 | awk -F 'value =' '{print $2}' | awk '{print $1}' | sed 's/,//')

FILE_TO_MONITOR="$HOME/.config/waybar/bin/brightness.val"

inotifywait -qm -e modify "$FILE_TO_MONITOR" | while read -r; do
    cat "$FILE_TO_MONITOR"
done

