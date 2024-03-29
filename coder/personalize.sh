#!/bin/bash
# For coder workspaces: If only your home directory persists, what things need to be run at startup?
#
# Our default installation has older/incompatible versions of nvim and fzf
sudo apt remove -y neovim fzf
sudo tar -C /opt -xzf dotfiles/nvim-linux64.tar.gz

sudo apt install -y ansible-lint
sudo npm install -g prettier
