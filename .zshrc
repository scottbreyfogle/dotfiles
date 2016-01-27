# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="sbreyfogle"

# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# Set to this to use case-sensitive completion
# CASE_SENSITIVE="true"

# Comment this out to disable bi-weekly auto-update checks
DISABLE_AUTO_UPDATE="true"

# Uncomment to change how many often would you like to wait before auto-updates occur? (in days)
# export UPDATE_ZSH_DAYS=13

# Uncomment following line if you want to disable colors in ls
# DISABLE_LS_COLORS="true"

# Uncomment following line if you want to disable autosetting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment following line if you want red dots to be displayed while waiting for completion
COMPLETION_WAITING_DOTS="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(command-not-found extract golang google pip tmux vi-mode zsh-syntax-highlighting)

source $ZSH/oh-my-zsh.sh

# Fzf
if [[ -a ~/.fzf.zsh ]]; then
  source ~/.fzf.zsh
  bindkey -M viins '^R' fzf-history-widget
  bindkey -M vicmd '^R' fzf-history-widget
  bindkey '^T' fzf-file-widget
  bindkey '^A' fzf-cd-widget
fi

########################################################
################## My Config ###########################
########################################################

ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets pattern)

# Fix special keys
source ~/.zshkeys

# Vim 4 lyfe
VISUAL=vim
EDITOR=vim
bindkey -v

# Reintroduce some emacs commands (for shame) (and convenience)
bindkey -M viins '^A' beginning-of-line
bindkey -M vicmd '^A' beginning-of-line
bindkey -M viins '^E' end-of-line
bindkey -M vicmd '^E' end-of-line
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
alias gh="history | grep"
alias fn="noglob find . -name"
alias svim="sudo -e"

# Global aliases
alias -g bry=breyfogle
alias -g swb=scottbreyfogle
alias -g pg="| egrep"
alias -g pl="2>&1 | less"
alias -g pc="| xclip -f -sel clip"

# Edit configs
alias zre="source ~/.zshrc"
alias zrc="$EDITOR ~/.zshrc"
alias vrc="$EDITOR ~/.vimrc"
alias xrc="$EDITOR ~/.xmonad/xmonad.hs"

function keys {
    scp feanor:~/.ssh/id_rsa .ssh
    scp feanor:~/.ssh/id_rsa.pub .ssh
    scp feanor:~/.ssh/authorized_keys .ssh
    ssh-add ~/.ssh/id_rsa
}

# History. See http://zsh.sourceforge.net/Guide/zshguide02.html#l18
HISTSIZE=150000
SAVEHIST=150000
HIST_EXPIRE_DUPS_FIRST=true # Remove duplicate commands (I'm looking at you ls) first
HIST_FIND_NO_DUPS=true # Generally don't want to find the same command multiple times
HIST_IGNORE_SPACE=true # Easy way to avoid logging a command: start it with a space
SHARE_HISTORY=true # Share history between running shells
EXTENDED_HISTORY=true # Store history start and running time.
HIST_REDUCE_BLANK=true # Remove spaces for better 

if [[ -a ~/.google/zshrc ]]; then
  source ~/.google/zshrc
else
  source ~/.personal/zshrc
fi
