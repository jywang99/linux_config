#!/bin/bash

# Example:
# method call time=1725934909.203086 sender=:1.3576 -> destination=org.fcitx.Fcitx5 serial=2 path=/controller; interface=org.fcitx.Fcitx.Controller1; member=SetCurrentIM
#   string "keyboard-us"

hit=0

echo_label() {
    case $1 in
        "keyboard-us") echo "EN";;
        "mozc") echo "JP";;
        "pinyin") echo "CN";;
    esac
}

echo_label $(fcitx5-remote -n)

# continuously monitor dbus messages
dbus-monitor "type='method_call',destination='org.fcitx.Fcitx5',member='SetCurrentIM'" 2>/dev/null | while read -r line; do
    if [[ $hit -eq 1 ]]; then
        # get input method
        currentIM=$(echo "$line" | grep -oP "string \"\K[^\"]+")
        echo_label "$currentIM"
        hit=0
        continue
    fi

    # if current line is method call to SetCurrentIM, next line contains input method
    if echo "$line" | grep -q "SetCurrentIM"; then
        hit=1
    fi
done

