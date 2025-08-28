# Tmuxifier window layout for coding workflow

window_root "$PWD"

# Create the main code window
new_window "code $(basename "$PWD")"

# Split horizontally - right pane 50% for coding-agent
split_h 50

# Select left pane and split vertically - bottom pane 50% for unit tests
select_pane 0
split_v 50

# Select top-left pane and split horizontally - right pane 50% for git status
select_pane 0
split_h 50

# Select the commands pane (top-left-left)
select_pane 0

# Set up git status monitoring in top-right pane
select_pane 1
run_cmd lazygit

# Set up unit tests pane
select_pane 2

# Set up main pane
select_pane 3

# Return to commands pane
select_pane 0
