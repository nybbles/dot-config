# Tmuxifier window layout for coding
# Split vertically with right pane at 30%

# Create the main coding window
new_window "coding"

# Split the window vertically with right pane 30% of screen
split_h 15

# Select the left pane (main coding pane)
select_pane 0
run_cmd "nvim" 
