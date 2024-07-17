#!/bin/bash
# For coder workspaces: If only your home directory persists, what things need to be run at startup?

# Quick config
sudo chsh scott -s /usr/bin/zsh
sudo timedatectl set-timezone America/Los_Angeles

# Reinstall neovim, and remove system fzf
# Our default installation has older/incompatible versions of nvim and fzf
sudo apt remove -y neovim fzf
sudo tar -C /opt -xzf dotfiles/nvim-linux64.tar.gz

# Install other packages
sudo apt install -y ansible-lint graphviz
sudo npm install -g prettier typescript typescript-language-server
pip install nvitop
