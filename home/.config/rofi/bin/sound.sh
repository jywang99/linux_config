#!/bin/sh
# lists pulseaudio sinks and switches default sink to the selected one
# (also works with PA server on Fedora's Pipewire)
#
# uses wl-clipboard: https://github.com/bugaevc/wl-clipboard
#
# prevent Xwayland from being started needlessly
unset DISPLAY

# determine currently configured sink
current=$(pactl list short sinks | grep "`pactl get-default-sink`" | cut -f1)

# present list and draw a fancy emoji in front of the current sink;
# the paste command takes two successive lines and joins them as one
chosen=$(pactl list sinks | grep -E '^Sink|device.description' | \
		paste -d " " - - | sed 's/Sink \#//' | sed 's/device.description = //' | \
		sed 's/"//g' | sed "s/$current/* $current/" | sed 's/^\([0-9]\+\)/   \1/' |\
		$HOME/.config/rofi/bin/launcher -dmenu -p "select audio output" -i -l 10)

# nothing selected
[ "$chosen" != "" ] || exit

# separate id and name
id=$(echo "$chosen" | sed 's/*//' | awk '{print $1}')
name=$(echo "$chosen" | awk '{$1=""; print $0}' | sed 's/^ *//')

# switch sink, pop notification, and play a sound on the switched sink
err=$(pactl set-default-sink $id 2>&1)
if [ $? -ne 0 ]; then
    notify-send "Error switching audio output" "$err" -t 5000 -u critical &
    exit 1
fi
notify-send "Switched audio output" "${name}" -t 5000 -u normal &

