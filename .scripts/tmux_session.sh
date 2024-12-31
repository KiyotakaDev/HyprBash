#!/bin/bash

create_session() {
  local session_name=$1
  local initial_command=$2

  # Checks if session exists
  if ! tmux has-session -t "$session_name" &> /dev/null; then
    # If not create session
    tmux new-session -d -s "$session_name" "${initial_command}; bash"
  fi
}

# Create sessions
create_session "MAIN" "echo 'Welcome to Main session'"
create_session "2ND" "echo 'Welcome to 2ND session'"

# Open kitty and attach tmux session
kitty tmux attach-session -t "MAIN"
