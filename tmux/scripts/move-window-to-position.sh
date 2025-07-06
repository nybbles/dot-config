#!/bin/bash

# Script to move a tmux window to a specific position by "bubbling" through adjacent positions
# Usage: move-window-to-position.sh <target_position>

set -e

if [ $# -ne 1 ]; then
    echo "Usage: $0 <target_position>"
    exit 1
fi

target="$1"

# Get current window index
current=$(tmux display-message -p '#{window_index}')

# Validate that target is a number
if ! [[ "$target" =~ ^[0-9]+$ ]]; then
    tmux display-message "Error: Target position must be a number"
    exit 1
fi

# Get the highest window index (last window position)
last_window=$(tmux list-windows -F '#{window_index}' | sort -n | tail -1)

# If target is beyond the last window, move to the end
if [ "$target" -gt "$last_window" ]; then
    target="$last_window"
fi

# If already at target position, do nothing
if [ "$current" -eq "$target" ]; then
    if [ "$1" -gt "$last_window" ]; then
        tmux display-message "Already at last position ($target)"
    else
        tmux display-message "Already at position $target"
    fi
    exit 0
fi

# Bubble the window to the target position
while [ "$current" -ne "$target" ]; do
    if [ "$current" -gt "$target" ]; then
        # Moving left: swap with window to the left
        next=$((current - 1))
        tmux swap-window -s "$current" -t "$next"
        current="$next"
    else
        # Moving right: swap with window to the right
        next=$((current + 1))
        tmux swap-window -s "$current" -t "$next"
        current="$next"
    fi
done

# Select the target window (where we moved to)
tmux select-window -t "$target"

# Clear any displayed messages/windows list
tmux clear-history 2>/dev/null || true

# Show appropriate message
if [ "$1" -gt "$last_window" ]; then
    tmux display-message "Moved window to last position ($target)"
else
    tmux display-message "Moved window to position $target"
fi