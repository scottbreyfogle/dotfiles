#!/usr/bin/zsh
# Stop the script if any command returns an error.
set -o errexit

pushd ~/dotfiles
nonstow/fzf/uninstall
stow -v 2 -D git ssh tmux vim zsh
popd
