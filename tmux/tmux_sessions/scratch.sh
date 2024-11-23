#!/bin/bash
set -e

if [ $# -ne 1 ]; then
  echo "Usage: ws.sh <scratch_name>" && exit 1
fi
WORKSPACE_NAME=$1
WORKING_DIRECTORY="$HOME/scratch/$WORKSPACE_NAME"
mkdir -p "$WORKING_DIRECTORY"

if tmux has-session -t "${WORKSPACE_NAME}" 2> /dev/null; then
  tmux attach-session -t "${WORKSPACE_NAME}"
else
  tmux new-session -d -c "${WORKING_DIRECTORY}" -s ${WORKSPACE_NAME}
  tmux new-window -c "${WORKING_DIRECTORY}" -t "${WORKSPACE_NAME}:2"
  tmux attach-session -t "${WORKSPACE_NAME}:1"
fi
