autoload -Uz compinit
compinit

autoload -U promptinit
promptinit

autoload -U colors
colors

if [[ "$USER" == root ]]; then
    PROMPT="%{$bold_color$fg[red]%}%m %{$bold_color$fg[blue]%}%1~ %# %{$reset_color%}"
else
    PS1="%{$bold_color$fg[blue]%}[%{$bold_color$fg[red]%}%1~%{$bold_color$fg[blue]%}] %{$bold_color$fg[yellow]%}> %{$reset_color%}"
    # PS1=$'\e[0;31m$ \e[0m'
fi

setopt SHARE_HISTORY
setopt EXTENDED_HISTORY
setopt EXTENDED_GLOB

setopt promptsubst

WORDCHARS=${WORDCHARS//[&=\/;!#%{}-]}

# End of lines added by compinstall
zstyle ':completion:*' glob 1
zstyle ':completion:*' menu select=long-list select=0
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}

# ignore files already given for rm, kill, diff
zstyle ':completion:*:(rm|kill|diff):*' ignore-line yes

# interactive configuration
setopt nonomatch # dont print error if no match is found
setopt correct # correct spelling mistakes in commands
setopt autocd # change to directory without "cd"
setopt auto_list # auto-list all completion choices when hitting TAB

# automenu is needed for menu-based selection
setopt auto_menu # don't auto-list first match
unsetopt extendedglob

for file in $HOME/.zsh/*; do
    source $file
done

xset r rate 200 50
