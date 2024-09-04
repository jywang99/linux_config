#!/bin/bash

# args
if [[ $# -ne 2 ]]; then
    echo "Usage: $0 <workspace_name> <floating>"
    echo "floating: true or false"
    exit 1
fi
targetWsName=$1
floating=$2

# address of active window
winfo=$(hyprctl activewindow -j)
winAddr=$(echo $winfo | jq -r '.address')
winFloating=$(echo $winfo | jq -r '.floating')

# move to target workspace
hyprctl dispatch movetoworkspace "address:$winAddr workspace:$targetWsName"
hyprctl dispatch movetoworkspace "$targetWsName,address:$winAddr"

# set layout
echo "winFloating: $winFloating, floating: $floating"
if ! [[ $winFloating == $floating ]]; then
    if [[ "$floating" == "false" ]]; then
        hyprctl dispatch settiled "address:$winAddr"
    else
        hyprctl dispatch setfloating "address:$winAddr"
    fi
fi

