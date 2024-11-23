#!/bin/bash
set -e

WORKSPACE_NAME=config
WORKING_DIRECTORY="$HOME/dotfiles"

if tmux has-session -t "${WORKSPACE_NAME}" 2> /dev/null; then
  tmux attach-session -t "${WORKSPACE_NAME}"
else
  tmux new-session -d -c "${WORKING_DIRECTORY}" -s ${WORKSPACE_NAME}

  tmux rename-window -t "${WORKSPACE_NAME}:1" zsh
  tmux send-keys -t "${WORKSPACE_NAME}:1" zrc C-m
  tmux new-window -c "${WORKING_DIRECTORY}" -t "${WORKSPACE_NAME}:2" -n vim
  tmux send-keys -t "${WORKSPACE_NAME}:2" vrc C-m
  tmux new-window -c "${WORKING_DIRECTORY}" -t "${WORKSPACE_NAME}:3" -n console

  tmux attach-session -t "${WORKSPACE_NAME}:1"
fi
