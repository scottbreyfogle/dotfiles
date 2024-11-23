#!/bin/bash
set -e

if ! ([ $# -eq 1 ] || [ $# -eq 2 ]); then
  echo "Usage: ws.sh <workspace_name> [<repo>]" && exit 1
fi
WORKSPACE_NAME=$1
if [ "$2" = "ai" ]; then
  REPO="descript-ai-workers"
elif [ "$2" = "d" ]; then
  REPO="descript"
elif [ "$2" = "w" ]; then
  REPO="descript-workflows"
elif [ "$2" = "infra" ]; then
  REPO="server-infrastructure"
else
  REPO=${2:-"descript-ai-workers"}
fi
WORKING_DIRECTORY="$HOME/src/$REPO"

LOCKFILE="$HOME/dotfiles/tmux/tmux_sessions/.${WORKSPACE_NAME}.lock"
# Remove lock file if it exists
[ -d "$LOCKFILE" ] && rm -r "$LOCKFILE"

function await_lock() {
  COUNTER=0
  while true; do
    if mkdir "$1" 2> /dev/null; then
      break
    fi
    ((COUNTER ++)) || true
    if [ $COUNTER -eq 10 ]; then
      echo "Awaiting return of git commands..."
      COUNTER=0
    fi
    sleep .1 || true
  done
}

# Check if repo is not clean

if tmux has-session -t "${WORKSPACE_NAME}" 2> /dev/null; then
  tmux attach-session -t "${WORKSPACE_NAME}"
else
  tmux new-session -d -c "${WORKING_DIRECTORY}" -s ${WORKSPACE_NAME}

  tmux new-window -c "${WORKING_DIRECTORY}" -t "${WORKSPACE_NAME}:2" -n console
  mkdir "$LOCKFILE"
  tmux send-keys -t "${WORKSPACE_NAME}:2" "git co \"swb/${WORKSPACE_NAME}\" || (git co main && git pull && git co -b \"swb/${WORKSPACE_NAME}\")" C-m
  tmux send-keys -t "${WORKSPACE_NAME}:2" "git status && rmdir $LOCKFILE" C-m
  await_lock "$LOCKFILE"
  tmux send-keys -t "${WORKSPACE_NAME}:1" vgo C-m

  tmux attach-session -t "${WORKSPACE_NAME}:1"
fi
