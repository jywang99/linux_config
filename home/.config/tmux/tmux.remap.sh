#!/bin/bash

# Remaps that change according to some conditions

if command -v xclip > /dev/null 2>&1; then
    tmux bind -T copy-mode-vi y send-keys -X copy-pipe 'xclip -in -selection clipboard'
else
    tmux bind -T copy-mode-vi y send-keys -X copy-selection
fi

