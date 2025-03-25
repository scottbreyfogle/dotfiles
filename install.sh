# Stop the script if any command returns an error.
set -o errexit
set -x

sudo apt update
# Install tools that are being configured
sudo apt install -y git zsh tmux stow ripgrep
# Neovim in Ubuntu 22lts is really old
mkdir -p ~/local_vim ~/bin
curl -L https://github.com/neovim/neovim/releases/latest/download/nvim-linux-x86_64.tar.gz --output ~/local_vim/vim.tar.gz
tar --directory ~/local_vim -xzf ~/local_vim/vim.tar.gz
ln -s "$HOME/local_vim/nvim-linux-x86_64/bin/nvim" "$HOME/bin/nvim"

# git needs to run from this directory
cd ~/dotfiles
# Init all submodules
git submodule update --recursive --init

# Installing LSP and linters
sudo apt install bat ansible-lint golang npm shellcheck
sudo npm install -g prettier pyright typescript typescript-language-server
pip install ruff black flake8 nvitop reorder-python-imports
go install golang.org/x/tools/gopls@latest
go install github.com/rhysd/actionlint/cmd/actionlint@latest

# stow needs to run from this directory
cd ~/dotfiles
# Symlink configs in main home directory
# E.G. ~/.gitconfig -> ~/dotfiles/git/.gitconfig
if [ -e ~/.gitconfig ]; then
    mv ~/.gitconfig ~/.gitconfig.old
fi
stow -v 2 git readline ssh tmux vim zsh coder
# ~/.config/nvim -> ~/dotfiles/nvim/.config/nvim
stow -v 2 -t ~/.config -d nvim .config
# ~/.local/share/nvim -> ~/dotfiles/nvim/.local/share/nvim
stow -v 2 -t ~/.local/share -d nvim/.local share
# Install fzf (fuzzy history search)
nonstow/fzf/install --all
# Aftercare:
# Conda initialization and moving results to .local.zshrc
# Adding email to .local.gitconfig
