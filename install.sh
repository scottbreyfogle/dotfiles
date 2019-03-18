# Stop the script if any command returns an error.
set -o errexit

# Create a directory where vim backup files can be stored.
mkdir -p ~/.vim_files
# Install tools that are being configured
sudo apt install git vim zsh tmux

# git and stow need to run from this directory
cd ~/dotfiles
# Init all submodules
# TODO: Maybe don't update all of them and just init instead?
git submodule update --recursive --remote --init
# Compile ycm
sudo apt install build-essential cmake python3-dev
cd ~/dotfiles/vim/.vim/bundle/ycm
./install.py --clang-completer --ts-completer
# Symlink configs in main home directory
stow -v 2 git ssh tmux vim zsh
# Install fzf (fuzzy history search)
nonstow/fzf/install --all
# Install solarized color scheme in gnome terminal
nonstow/solarized/gnome-terminal-colors-solarized/install.sh --skip-dircolors -s dark
