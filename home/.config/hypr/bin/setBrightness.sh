#!/bin/bash

# set brightness
ddcutil setvcp 10 $@

# get current brightness
current=$(ddcutil getvcp 10 | awk -F 'value =' '{print $2}' | awk '{print $1}' | sed 's/,//')
echo $current > $HOME/.config/hypr/events/brightness

