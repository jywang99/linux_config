#!/usr/bin/env bash

dir="$HOME/.config/rofi/variants/launcher"
theme='style-1'

rofi \
    -theme ${dir}/${theme}.rasi \
    $@
