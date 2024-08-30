#!/bin/bash

layout=$1
case $1 in
    0) cmd="settiled" ;;
    1) cmd="setfloating" ;;
    *) echo "Usage: $0 <0|1>"; exit 1 ;;
esac

# get active workspace
winfo=$(hyprctl activewindow -j)
wsid=$(echo $winfo | jq -r '.workspace.id')

# get all clients in workspace
client_addrs=$(hyprctl clients -j|jq -r ".[] | select(.workspace.id == $wsid)|.address")

# toggle floating
echo "$client_addrs" | while read -r addr; do
    hyprctl dispatch $cmd "address:$addr"
done

