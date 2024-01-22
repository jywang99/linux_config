#!/bin/bash

SESSION_NAME="dev"

# If the session exists, attach to it
if tmux has-session -t $SESSION_NAME 2>/dev/null; then
    tmux attach-session -t $SESSION_NAME
    exit 0
fi

tmux new-session -d -s $SESSION_NAME

tmux new-window -t $SESSION_NAME:0 -n 'config'
tmux new-window -t $SESSION_NAME:1 -n 'config'
tmux new-window -t $SESSION_NAME:2 -n 'proj'
tmux new-window -t $SESSION_NAME:3 -n 'deploy'

# For some reason, the first window doesn't get renamed without this'
tmux select-window -t 1
tmux kill-window

tmux attach-session -t $SESSION_NAME

