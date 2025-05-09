if [[ -a ~/.before.zshrc ]]; then
  source ~/.before.zshrc
fi

# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
ZSH_CUSTOM=$HOME/.zsh_custom

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="sbreyfogle"

# Comment this out to disable bi-weekly auto-update checks
DISABLE_AUTO_UPDATE="true"

# Uncomment following line if you want to disable autosetting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment following line if you want red dots to be displayed while waiting for completion
COMPLETION_WAITING_DOTS="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(command-not-found docker-compose docker extract gcloud git golang kubectl pip tmux vault vi-mode zsh-syntax-highlighting)

source $ZSH/oh-my-zsh.sh

# Fzf
if [[ -a ~/.fzf.zsh ]]; then
  export FZF_DEFAULT_OPTS="--exact"
  source ~/.fzf.zsh
  bindkey -M viins '^R' fzf-history-widget
  bindkey -M vicmd '^R' fzf-history-widget
  bindkey '^T' fzf-file-widget
  bindkey '^A' fzf-cd-widget
  FZF_TMUX=$TMUX
fi

# Solarized colors on ls. Run if dircolors is installed
if command -v dircolors > /dev/null; then
    eval `dircolors ~/dotfiles/nonstow/solarized/dircolors-solarized/dircolors.ansi-dark`
fi

# Start ssh-agent, once.
if [ ! -S ~/.ssh/ssh_auth_sock ]; then
  eval `ssh-agent -s`
  ln -sf "$SSH_AUTH_SOCK" ~/.ssh/ssh_auth_sock
fi
export SSH_AUTH_SOCK=~/.ssh/ssh_auth_sock
ssh-add -q

########################################################
################## My Config ###########################
########################################################

ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets pattern)

# Fix special keys
source ~/.zshkeys

# Vim 4 lyfe
export VISUAL=nvim
export EDITOR=nvim
alias vim=nvim
bindkey -v
# Get backspace working after entering and exiting command mode
bindkey "^?" backward-delete-char

# Disallow antiquated ctrl-q/ctrl-s
stty stop undef
stty start undef
stty -ixon
stty -ixoff

# Aliases
alias l=ls
alias ll="ls -l"
alias la="ls -la"
alias grep=egrep
alias pg="ps -e | egrep"
alias ghi="history | grep"
alias fn="noglob find . -name"
alias svim="sudo -e"
alias ws="bash ~/dotfiles/tmux/tmux_sessions/ws.sh"
alias scratch="bash ~/dotfiles/tmux/tmux_sessions/scratch.sh"
alias config="bash ~/dotfiles/tmux/tmux_sessions/config.sh"
alias prod-db="bash ~/dotfiles/tmux/tmux_sessions/sql.sh"

# Global aliases
alias -g bry=breyfogle
alias -g swb=scottbreyfogle
alias -g vlsp=~/.local/state/nvim/lsp.log
alias -g pg="| egrep"
alias -g pl="2>&1 | less"
alias -g pc="| xclip -f -sel clip"

# Source config
alias zre="source ~/.zshrc"
# Edit files
alias zrc="(setopt nullglob && $EDITOR ~/.zshrc ~/.*.zshrc)"
alias vrc="$EDITOR ~/.config/nvim/init.vim ~/.config/nvim/lua/swb/**/*.lua"
alias vgo='$EDITOR $(git status --porcelain -s | awk '\''{print $2}'\'')'
# In Ubuntu, bat is installed as batcat
if type batcat > /dev/null; then
    alias bat=batcat
fi

# History. See http://zsh.sourceforge.net/Guide/zshguide02.html#l18
HISTSIZE=150000
SAVEHIST=150000
setopt HIST_EXPIRE_DUPS_FIRST # Remove duplicate commands (I'm looking at you ls) first
setopt HIST_FIND_NO_DUPS # Generally don't want to find the same command multiple times
setopt HIST_IGNORE_SPACE # Easy way to avoid logging a command: start it with a space
setopt SHARE_HISTORY # Share history between running shells
setopt EXTENDED_HISTORY # Store history start and running time.
setopt HIST_REDUCE_BLANKS # Remove spaces for better deduplication
# TODO: What's the path for macos?
export PATH=$PATH:$HOME/bin:$HOME/vim_bin:$HOME/go/bin

if [[ -a ~/.after.zshrc ]]; then
  source ~/.after.zshrc
fi
# .local.zshrc is for local machine specific settings that won't be added to git. Conda init
# clauses are a good example.
if [[ -a ~/.local.zshrc ]]; then
  source ~/.local.zshrc
fi

if [[ -a ~/secrets/openai ]]; then
  export OPENAI_API_KEY=$(<$HOME/secrets/openai)
fi
if [[ -a ~/secrets/anthropic ]]; then
    export ANTHROPIC_API_KEY=$(<$HOME/secrets/anthropic)
fi
