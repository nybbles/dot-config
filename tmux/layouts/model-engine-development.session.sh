# Set a custom session root path. Default is `$HOME`.
# Must be called before `initialize_session`.
#session_root "~/Projects/model-engine-development"

session_root "~/code/echostat/EASI_model_engine"

# Create session with specified name if it does not already exist. If no
# argument is given, session name will be based on layout file name.
if initialize_session "model-engine-development"; then

  # Create a new window inline within session layout definition.
  new_window "code"
  run_cmd "poetry run nvim"

  new_window "git-stuff"
  run_cmd lazygit
  split_h 30

  # Load a defined window layout.
  #load_window "example"

  # Select the default active window on session creation.
  select_window 0

fi

# Finalize session creation and switch/attach to it.
finalize_and_go_to_session
