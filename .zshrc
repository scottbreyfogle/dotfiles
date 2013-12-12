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
plugins=(archlinux command-not-found extract gem git golang pip systemd tmux vi-mode zsh-syntax-highlighting)

source $ZSH/oh-my-zsh.sh

########################################################
################## My Config ###########################
########################################################

# Fix special keys
source ~/.zshkeys

# Vim 4 lyfe
VISUAL=vim
EDITOR=vim
bindkey -v
# Prevent lag after hitting escape
KEYTIMEOUT=1

# Reintroduce some emacs commands (for shame) (and convenience)
bindkey -M viins '^R' history-incremental-search-backward
bindkey -M vicmd '^R' history-incremental-search-backward
bindkey -M viins '^A' beginning-of-line
bindkey -M vicmd '^A' beginning-of-line
bindkey -M viins '^E' end-of-line
bindkey -M vicmd '^E' end-of-line

# Disallow antiquated ctrl-q/ctrl-s
stty stop undef
stty start undef
stty -ixon
stty -ixoff

# Aliases
alias g=git
compdef g=git
alias v=vim
compdef v=vim
alias zrc="$EDITOR ~/.zshrc"
alias vrc="$EDITOR ~/.vimrc"
function keys {
    scp feanor:~/.ssh/id_rsa .ssh
    scp feanor:~/.ssh/id_rsa.pub .ssh
    scp feanor:~/.ssh/authorized_keys .ssh
    ssh-add ~/.ssh/id_rsa
}
# Everyone likes talking computers
if ((! type say) && type mplayer) > /dev/null; then
    function say { mplayer "http://translate.google.com/translate_tts?tl=en&q=$1" > /dev/null }
fi

export PYTHONPATH=/usr/lib/python3.3/site-packages
export PATH=$PATH:/opt/java/bin:/opt/java/db/bin:/opt/java/jre/bin:/usr/bin/core_perl:$HOME/bin:$HOME/.rvm/bin:$HOME/go_appengine
export GOPATH=$HOME/go
