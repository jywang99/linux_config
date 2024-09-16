#!/usr/bin/env bash

dir="$HOME/.config/rofi/variants/loading"
theme='style-1'

rofi \
    -theme ${dir}/${theme}.rasi \
    $@

