# Load Autojump
# sudo apt-get install autojump
source /usr/share/autojump/autojump.zsh

#Disable Autcorrectur
unsetopt correct_all

#Defaults
export EDITOR="vim"
export VISUAL="vim"
export BROWSER="google-chrome"

# Remove words by one by, instead of fullpath
# i.eg C-w will remove "bar" from "/foo/bar" and not the whole path
export WORDCHARS=''

bindkey -e

# emacs mode
autoload edit-command-line
zle -N edit-command-line
bindkey '^Xe' edit-command-line

###########
# ALIASES #
###########

alias -s markdown=vim
alias -s txt=vim




#cit
PATH=$PATH:"/home/fatih/cit/"
alias cit="cit.py"

#todo.txt
PATH=$PATH:"/home/fatih/Dropbox/todo/"
alias t="todo.sh -d /home/fatih/Dropbox/todo/todo.cfg"

# List direcory contents
alias ls='ls --color=auto'
alias lsa='ls -lah'
alias l='ls -la'
alias ll='ls -l'
alias sl=ls # often screw this up

alias dg="git diff"
alias u="svn up"
alias m="vim Makefile"

alias sil="rm *.pisi"

alias c="clear"
alias cls="clear && ls"
alias rm="rm -f"

alias tmux="tmux -2"
alias find32="find *  | xargs file | grep '32-bit'"

# Directories
setopt auto_pushd
setopt pushd_ignore_dups
alias ..='cd ..'
alias cd..='cd ..'

# alias 1='cd -'
# alias 2='cd +2'
# alias 3='cd +3'
# alias 4='cd +4'
# alias 5='cd +5'
# alias 6='cd +6'
# alias 7='cd +7'
# alias 8='cd +8'
# alias 9='cd +9'

# cd () {
  # if   [[ "x$*" == "x..." ]]; then
    # cd ../..
  # elif [[ "x$*" == "x...." ]]; then
    # cd ../../..
  # elif [[ "x$*" == "x....." ]]; then
    # cd ../../..
  # elif [[ "x$*" == "x......" ]]; then
    # cd ../../../..
  # else
    # builtin cd "$@"
  # fi
# }

##############
# COMPLETION #
##############

unsetopt menu_complete   # do not autoselect the first completion entry
unsetopt flowcontrol
setopt auto_menu         # show completion menu on succesive tab press
setopt complete_in_word
setopt always_to_end

zmodload -i zsh/complist

## case-insensitive (all),partial-word and then substring completion
if [ "x$CASE_SENSITIVE" = "xtrue" ]; then
  zstyle ':completion:*' matcher-list 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'
  unset CASE_SENSITIVE
else
  zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'
fi

zstyle ':completion:*' list-colors ''

# should this be in keybindings?
bindkey -M menuselect '^o' accept-and-infer-next-history

zstyle ':completion:*:*:*:*:*' menu select
zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#) ([0-9a-z-]#)*=01;34=0=01'
zstyle ':completion:*:*:*:*:processes' command "ps -u `whoami` -o pid,user,comm -w -w"

# disable named-directories autocompletion
zstyle ':completion:*:cd:*' tag-order local-directories directory-stack path-directories
cdpath=(.)

# use /etc/hosts and known_hosts for hostname completion
[ -r ~/.ssh/known_hosts ] && _ssh_hosts=(${${${${(f)"$(<$HOME/.ssh/known_hosts)"}:#[\|]*}%%\ *}%%,*}) || _ssh_hosts=()
[ -r /etc/hosts ] && : ${(A)_etc_hosts:=${(s: :)${(ps:\t:)${${(f)~~"$(</etc/hosts)"}%%\#*}##[:blank:]#[^[:blank:]]#}}} || _etc_hosts=()
hosts=(
  "$_ssh_hosts[@]"
  "$_etc_hosts[@]"
  `hostname`
  localhost
)
zstyle ':completion:*:hosts' hosts $hosts


###########
# HISTORY #
###########

## Command history configuration
HISTFILE=$HOME/.zsh_history
HISTSIZE=100000
SAVEHIST=100000

setopt hist_ignore_dups # ignore duplication command history list
setopt share_history # share command history data

setopt hist_verify
setopt inc_append_history
setopt extended_history
setopt hist_expire_dups_first
setopt hist_ignore_space

setopt SHARE_HISTORY
setopt APPEND_HISTORY

#KEYBINDINGS
bindkey '^r' history-incremental-search-backward

# make search up and down work, so partially type and hit up/down to find relevant stuff
bindkey '^[[A' up-line-or-search
bindkey '^[[B' down-line-or-search

## smart urls
autoload -U url-quote-magic
zle -N self-insert url-quote-magic

## file rename magick
bindkey "^[m" copy-prev-shell-word

## jobs
setopt long_list_jobs

## pager
export PAGER=less
export LC_CTYPE=$LANG

# Setup the prompt with pretty colors
setopt prompt_subst

# ls colors
autoload colors; colors;
export lscolors="gxfxcxdxbxegedabagacad"

PS1="%{$fg[red]%}%B%n%b%{$reset_color%}@%{$fg[blue]%}%B%m%b %{$fg[yellow]%}%B%1~%b %{$reset_color%}%% "

# Binary,Dec and Hex conversion functions
#
h2d(){
  echo "ibase=16; $@"|bc
}
d2h(){
  echo "obase=16; $@"|bc
}

h2b(){
  echo "ibase=16;obase=2; $@"|bc
}
b2h(){
  echo "obase=2;obase=16; $@"|bc
}

d2b(){
  echo "ibase=16; $@"|bc
}
b2d(){
  echo "obase=16; $@"|bc
}



# PLUGIN

# ------------------------------------------------------------------------------
#          FILE:  extract.plugin.zsh
#   DESCRIPTION:  oh-my-zsh plugin file.
#        AUTHOR:  Sorin Ionescu (sorin.ionescu@gmail.com)
#       VERSION:  1.0.1
# ------------------------------------------------------------------------------


function extract() {
  local remove_archive
  local success
  local file_name
  local extract_dir

  if (( $# == 0 )); then
    echo "Usage: extract [-option] [file ...]"
    echo
    echo Options:
    echo "    -r, --remove    Remove archive."
    echo
    echo "Report bugs to <sorin.ionescu@gmail.com>."
  fi

  remove_archive=1
  if [[ "$1" == "-r" ]] || [[ "$1" == "--remove" ]]; then
    remove_archive=0
    shift
  fi

  while (( $# > 0 )); do
    if [[ ! -f "$1" ]]; then
      echo "extract: '$1' is not a valid file" 1>&2
      shift
      continue
    fi

    success=0
    file_name="$( basename "$1" )"
    extract_dir="$( echo "$file_name" | sed "s/\.${1##*.}//g" )"
    case "$1" in
      (*.tar.gz|*.tgz) tar xvzf "$1" ;;
      (*.tar.bz2|*.tbz|*.tbz2) tar xvjf "$1" ;;
      (*.tar.xz|*.txz) tar --xz --help &> /dev/null \
        && tar --xz -xvf "$1" \
        || xzcat "$1" | tar xvf - ;;
      (*.tar.zma|*.tlz) tar --lzma --help &> /dev/null \
        && tar --lzma -xvf "$1" \
        || lzcat "$1" | tar xvf - ;;
      (*.tar) tar xvf "$1" ;;
      (*.gz) gunzip "$1" ;;
      (*.bz2) bunzip2 "$1" ;;
      (*.xz) unxz "$1" ;;
      (*.lzma) unlzma "$1" ;;
      (*.Z) uncompress "$1" ;;
      (*.zip) unzip "$1" -d $extract_dir ;;
      (*.rar) unrar e -ad "$1" ;;
      (*.7z) 7za x "$1" ;;
      (*.deb)
        mkdir -p "$extract_dir/control"
        mkdir -p "$extract_dir/data"
        cd "$extract_dir"; ar vx "../${1}" > /dev/null
        cd control; tar xzvf ../control.tar.gz
        cd ../data; tar xzvf ../data.tar.gz
        cd ..; rm *.tar.gz debian-binary
        cd ..
      ;;
      (*)
        echo "extract: '$1' cannot be extracted" 1>&2
        success=1
      ;;
    esac

    (( success = $success > 0 ? $success : $? ))
    (( $success == 0 )) && (( $remove_archive == 0 )) && rm "$1"
    shift
  done
}

alias x=extract

# add extract completion function to path
fpath=($ZSH/plugins/extract $fpath)
autoload -U compinit
compinit -i

# [[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"

