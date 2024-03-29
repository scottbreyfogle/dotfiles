# Stop the script if any command returns an error.
set -o errexit

# Create a directory where vim backup files can be stored.
mkdir -p ~/.vim_files
# Install tools that are being configured
sudo apt install git nvim zsh tmux stow

# git needs to run from this directory
cd ~/dotfiles
# Init all submodules
# TODO: Maybe don't update all of them and just init instead?
git submodule update --recursive --remote --init
sudo apt install build-essential python3-dev npm clangd-12 ripgrep
npm install -g typescript typescript-language-server

# stow needs to run from this directory
cd ~/dotfiles
# Symlink configs in main home directory
# E.G. ~/.gitconfig -> ~/dotfiles/git/.gitconfig
stow -v 2 git readline ssh tmux vim zsh
# ~/.config/nvim -> ~/dotfiles/nvim/.config/nvim
stow -v 2 -t ~/.config -d nvim .config
# ~/.local/share/nvim -> ~/dotfiles/nvim/.local/share/nvim
stow -v 2 -t ~/.local/share -d nvim/.local share
# Install fzf (fuzzy history search)
nonstow/fzf/install --all
# Aftercare:
# Conda initialization and moving results to .local.zshrc
# Adding email to .local.gitconfig
