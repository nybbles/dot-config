# Set a custom session root path. Default is `$HOME`.
# Must be called before `initialize_session`.
#session_root "~/Projects/computer-setup-work"

session_root "~/.config"

# Create session with specified name if it does not already exist. If no
# argument is given, session name will be based on layout file name.
if initialize_session "computer-setup-work"; then

	# Create a new window inline within session layout definition.
	new_window ".config"

	# Split the window vertically down the middle
	split_h 50

	# Left pane: lazygit for ~/.config
	select_pane 0
	run_cmd "lazygit"

	# Right pane: lazygit for ~/.config/nvim
	select_pane 1
	run_cmd "cd ~/.config/nvim && lazygit"

	# Add coding window
	new_window "code"
	window_root "~/.config"
	split_h 15

	# Select the default active window on session creation.
	select_window 1

	# Select the left pane (main coding pane)
	select_pane 0
	run_cmd "nvim"

fi

# Finalize session creation and switch/attach to it.
finalize_and_go_to_session
