#!/bin/bash

# named pipe for brightness
np=$HOME/.config/hypr/events/brightness
if [[ ! -p $np ]]; then
    rm -f $np
fi
mkfifo $np
current=$(ddcutil getvcp 10 | awk -F 'value =' '{print $2}' | awk '{print $1}' | sed 's/,//')
echo $current > $np

