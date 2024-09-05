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
		rofi -dmenu -p "select audio output" -i -l 10)

# nothing selected
[ "$chosen" != "" ] || exit

# only keep the ID
c=$(echo "$chosen" | sed 's/*//' | awk '{print $1}')

# switch sink, pop notification, and play a sound on the switched sink
pactl set-default-sink $c
notify-send "switched audio output to ${chosen}." -t 5000 -u low -i /usr/share/icons/gnome/256x256/devices/audio-speakers.png &
aplay /usr/share/sounds/speech-dispatcher/prompt.wav

