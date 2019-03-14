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
plugins=(extract git golang pip tmux vi-mode zsh-syntax-highlighting)

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

# Copied from chunk of .bashrc created by Anaconda3 2018.12 installer
# >>> conda init >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$(CONDA_REPORT_ERRORS=false '/home/scott/anaconda3/bin/conda' shell.bash hook 2> /dev/null)"
if [ $? -eq 0 ]; then
    \eval "$__conda_setup"
else
    if [ -f "/home/scott/anaconda3/etc/profile.d/conda.sh" ]; then
        . "/home/scott/anaconda3/etc/profile.d/conda.sh"
        CONDA_CHANGEPS1=false conda activate base
    else
        \export PATH="/home/scott/anaconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda init <<<

# Solarized colors on ls.
eval `dircolors ~/dotfiles/nonstow/solarized/dircolors-solarized/dircolors.ansi-dark`

########################################################
################## My Config ###########################
########################################################

ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets pattern)

# Fix special keys
source ~/.zshkeys

# Vim 4 lyfe
export VISUAL=vim
export EDITOR=vim
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
alias gh="history | grep"
alias fn="noglob find . -name"
alias svim="sudo -e"
alias yapf="python3 $HOME/.yapf/yapf"

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
setopt HIST_EXPIRE_DUPS_FIRST # Remove duplicate commands (I'm looking at you ls) first
setopt HIST_FIND_NO_DUPS # Generally don't want to find the same command multiple times
setopt HIST_IGNORE_SPACE # Easy way to avoid logging a command: start it with a space
setopt SHARE_HISTORY # Share history between running shells
setopt EXTENDED_HISTORY # Store history start and running time.
setopt HIST_REDUCE_BLANKS # Remove spaces for better deduplication
export PATH=$PATH:$HOME/bin

if [[ -a ~/.after.zshrc ]]; then
  source ~/.after.zshrc
fi
