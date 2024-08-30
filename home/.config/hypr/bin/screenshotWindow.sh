#!/bin/bash

winfo=$(hyprctl activewindow)
# Window 55d3e6300910 -> tmux a: mapped: 1 hidden: 0 at: 1407,45 size: 1141,1383 workspace: 1 (1) floating: 0 pseudo: 0 monitor: 0 class: kitty title: tmux a initialClass: kitty initialTitle: kitty pid: 9160 xwayland: 0 pinned: 0 fullscreen: 0 fullscreenClient: 0 grouped: 0 tags: swallowing: 0 focusHistoryID: 0

# get size, position
# format like 1564,409 173x196
pos=$(echo $winfo | grep -oP 'at: \K[^ ]+')
size=$(echo $winfo | grep -oP 'size: \K[^ ]+' | sed 's/,/x/')

# take screenshot
grim -g "$pos $size" - | wl-copy

