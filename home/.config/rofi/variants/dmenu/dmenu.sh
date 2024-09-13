#!/usr/bin/env bash

dir="$HOME/.config/rofi/variants/dmenu"
theme='style-1'

rofi \
    -theme ${dir}/${theme}.rasi \
    $@

