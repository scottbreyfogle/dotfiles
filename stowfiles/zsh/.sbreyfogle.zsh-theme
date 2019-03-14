if [ "$(whoami)" = "root" ]
then CARETCOLOR="red"
else CARETCOLOR="blue"
fi

local return_code="%(?..%{$fg[red]%}%? ↵%{$reset_color%})"
MODE_INDICATOR="%{$fg_bold[magenta]%}<%{$reset_color%}%{$fg[magenta]%}<<%{$reset_color%}"

# TODO use 265 colors
# MODE_INDICATOR="$FX[bold]$FG[020]<$FX[no_bold]%{$fg[blue]%}<<%{$reset_color%}"
# TODO use two lines if git

PROMPT='%F{$CARETCOLOR}%n :: %F{green}%~%F{$CARETCOLOR} [%f '
RPROMPT='$(vi_mode_prompt_info) ${return_code} %F{$CARETCOLOR}] %F{red}%D{%B %d, %L:%M%P}%f'
# RPROMPT='$(vi_mode_prompt_info) ${return_code} $(hg_prompt_info) %F{$CARETCOLOR}] %F{red}%D{%B %d, %L:%M%P}%f'

# ZSH_THEME_GIT_PROMPT_PREFIX="%F{yellow}"
# ZSH_THEME_GIT_PROMPT_SUFFIX="%f"
# ZSH_THEME_GIT_PROMPT_DIRTY=" %F{red}*%f"
# ZSH_THEME_GIT_PROMPT_CLEAN=""
# 
# ZSH_THEME_HG_PROMPT_PREFIX="%F{yellow}"
# ZSH_THEME_HG_PROMPT_SUFFIX="%f"
# ZSH_THEME_HG_PROMPT_DIRTY=" %F{red}*%f"
# ZSH_THEME_HG_PROMPT_CLEAN=""
