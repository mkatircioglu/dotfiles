if [[ "$USER" == root ]]; then
    PROMPT="%{$bold_color$fg[red]%}%m %{$bold_color$fg[blue]%}%1~ %# %{$reset_color%}"
else
    #PROMPT="%{$bold_color$fg[YELLOW]%}%m.%{$bold_color$fg[GREEN]%}%n %{$reset_color$fg[red]%}(%1~) : %{$reset_color%}"
    #PROMPT="%{$bold_color$fg[yellow]%}%n%{$bold_color$fg[blue]%}@%{$bold_color$fg[green]%}%m %{$bold_color$fg[blue]%}(%{$bold_color$fg[red]%}%1~%{$bold_color$fg[blue]%}) %{$bold_color$fg[white]%}: %{$reset_color%}"
    PROMPT="%{$bold_color$fg[blue]%}[%{$bold_color$fg[red]%}%1~%{$bold_color$fg[blue]%}] %{$bold_color$fg[yellow]%}> %{$reset_color%}"
fi

autoload -Uz compinit
compinit

# Load the prompt theme system
autoload -U promptinit
promptinit

setopt SHARE_HISTORY
setopt EXTENDED_HISTORY
setopt EXTENDED_GLOB

setopt promptsubst

# Use the wunjo prompt theme
#prompt wunjo
#
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

#setopt prompt_sp
