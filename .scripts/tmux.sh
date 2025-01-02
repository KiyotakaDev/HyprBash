#!/bin/bash

if [ ! -d "$HOME/Clones/.tmux/plugins/tpm" ]; then
  git clone https://github.com/tmux-plugins/tpm "$HOME/Clones/.tmux/plugins/tpm"
else
  echo "TMUX TPM already exists"
fi
