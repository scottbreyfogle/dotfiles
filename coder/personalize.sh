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
sudo apt update
sudo apt install -y bat ansible-lint graphviz build-essential libcairo2-dev libpango1.0-dev libjpeg-dev libgif-dev librsvg2-dev libxi-dev libglu1-mesa-dev libglew-dev pkg-config
sudo npm install -g prettier typescript typescript-language-server
