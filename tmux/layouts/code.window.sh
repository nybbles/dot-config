# Tmuxifier window layout for coding

window_root "$PWD"

# Create the main coding window
new_window "coding $(basename "$PWD")"

# Split the window vertically with right pane 15% of screen
split_h 30

# Select the left pane (main coding pane)
select_pane 0
run_cmd "nvim"
