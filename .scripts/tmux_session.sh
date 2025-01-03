#!/bin/bash

create_session() {
  local session_name=$1

  # Checks if session exists
  if ! tmux has-session -t "$session_name" &> /dev/null; then
    # If not create session
    tmux new-session -d -s "$session_name" "fastfetch; zsh"
  fi
}

# Create sessions
create_session "MAIN"

# Open kitty and attach tmux session
kitty tmux attach-session -t "MAIN"
