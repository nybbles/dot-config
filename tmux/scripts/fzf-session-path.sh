#!/usr/bin/env bash

# FZF-based directory picker for tmux session working directory
# Combines zoxide frequent directories with full directory tree

# Load fzf if available
if [[ -f ~/.fzf.bash ]]; then
    source ~/.fzf.bash
elif [[ -f ~/.fzf.zsh ]]; then
    source ~/.fzf.zsh
fi

# Ensure fzf is available
if ! command -v fzf >/dev/null 2>&1; then
    tmux display-message "Error: fzf not found"
    exit 1
fi

# Get current session name
SESSION=$(tmux display-message -p '#S')

# Function to get directories
get_directories() {
    {
        # Get zoxide frequent directories (marked with *)
        if command -v zoxide >/dev/null 2>&1; then
            zoxide query --list 2>/dev/null | head -10 | sed 's/^/* /'
        fi
        
        # Get common directories
        echo "  $HOME"
        echo "  /tmp"
        echo "  /opt"
        echo "  /usr/local"
        
        # Find directories in home with deeper search
        find "$HOME" -maxdepth 4 -type d 2>/dev/null | head -200 | sed 's/^/  /'
        
        # Find directories in current path if different from home
        if [[ "$PWD" != "$HOME"* ]]; then
            find "$PWD" -maxdepth 3 -type d 2>/dev/null | sed 's/^/  /'
        fi
        
        # Also search common project directories
        for dir in "$HOME/projects" "$HOME/code" "$HOME/dev" "$HOME/work" "$HOME/Documents"; do
            if [[ -d "$dir" ]]; then
                find "$dir" -maxdepth 3 -type d 2>/dev/null | sed 's/^/  /'
            fi
        done
    } | sort -u
}

# Use fzf to select directory
SELECTED=$(get_directories | fzf \
    --prompt "Select directory for session '$SESSION': " \
    --header "* = frequent (zoxide)" \
    | sed 's/^[* ] *//')

# Check if user selected something
if [[ -z "$SELECTED" ]]; then
    tmux display-message "No directory selected"
    exit 0
fi

# Expand tilde
SELECTED="${SELECTED/#\~/$HOME}"

# Check if directory exists
if [[ ! -d "$SELECTED" ]]; then
    tmux display-message "Error: Directory '$SELECTED' does not exist"
    exit 1
fi

# Get absolute path
ABS_PATH=$(realpath "$SELECTED")

# Set the default path for new windows in this session
tmux set-option -t "$SESSION" default-command "cd '$ABS_PATH' && \$SHELL"

# Display success message
tmux display-message "Session '$SESSION' working directory set to: $ABS_PATH"