#!/bin/zsh

# umask sets an environment variable which automatically sets file permissions on newly created files.
umask 022

# Set Zsh home directory and history file location.
# We want these out of the way an in their separate directory.
ZSH="$HOME/.zsh"
HISTFILE="$ZSH/history"

# Configure history size
HISTSIZE=40960
SAVEHIST=$HISTSIZE

# Turn on 256-colour terminal support.
[ -z "$TERM" ] || [[ "$TERM" == "xterm" ]] && export TERM=xterm-256color

# Configure preferred applications.
export EDITOR=vim
export PAGER=less

# Configure preferred language option.
export LANG="en_GB.UTF-8"
export LANGUAGE="en_GB:en_US:en"
export LC_MESSAGES="en_GB.UTF-8"

# Configure applications, e.g., grep, ack, etc.
export GREP_OPTIONS='--color=auto'
export GREP_COLOR='1;32'

export ACK_OPTIONS=--type-set=php=.php,.php3,.php4,.php5,.module,.inc,.install # PHP support for ack-grep

# Enable colour terminal and prompt.
autoload colors; colors;

function _prompt_type() {
  if [ $UID -eq 0 ]; then echo '#'; else echo '$'; fi
}

export LSCOLORS="Gxfxcxdxbxegedabagacad"
export PROMPT="%{%F{250}%}%n@%{%f%}%{%F{green}%}%m:%{%f%}%{%F{yellow}%}%(!.%1~.%~)%{%f%}%{%F{250}%}$(_prompt_type)%{%f%} " # format is 'login-name@machine-name:cwd %'

# Use a separate file to configure command aliases.
[[ -s "$HOME/.aliases" ]] && source "$HOME/.aliases"

# -g allows operations on parameters without making them local.
# -A Associative array. Each name will converted to an associate array. If a variable already exists, the current value will become index 0.
# FX FG BG make using 256 colors in zsh less painful.
typeset -Ag FX FG BG

FX=(
  reset     "%{[00m%}"
  bold      "%{[01m%}" no-bold      "%{[22m%}"
  italic    "%{[03m%}" no-italic    "%{[23m%}"
  underline "%{[04m%}" no-underline "%{[24m%}"
  blink     "%{[05m%}" no-blink     "%{[25m%}"
  reverse   "%{[07m%}" no-reverse   "%{[27m%}"
)

for color in {000..255}; do
  FG[$color]="%{[38;5;${color}m%}"
  BG[$color]="%{[48;5;${color}m%}"
done

# Allow variable substitution to take place in the prompt.
setopt prompt_subst

# Configure the auto-completion system.
autoload -U compinit
compinit -i
zmodload -i zsh/complist

zstyle ':completion:*' list-colors ''
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path $ZSH/cache

zstyle ':completion:*:descriptions' format '%U%B%d%b%u'
zstyle ':completion:*:warnings' format '%Bno matches for:%b %d'
zstyle ':completion:*:*:*:*:*' menu select
zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#) ([0-9a-z-]#)*=01;34=0=01'
zstyle ':completion:*:*:*:*:processes' command "ps -u `whoami` -o pid,user,comm -w -w"

# Disable named-directories autocompletion.
zstyle ':completion:*:cd:*' tag-order local-directories directory-stack path-directories
cdpath=(.)

# Enable advanced prompt and themes.
autoload -U promptinit
promptinit

# Options, options, options...
setopt hist_ignore_all_dups
setopt hist_ignore_space
setopt hist_verify
setopt append_history
setopt inc_append_history
setopt extended_history
setopt hist_find_no_dups
setopt hist_reduce_blanks
setopt hist_ignore_space
setopt hist_no_store
setopt hist_no_functions
setopt no_hist_beep
setopt hist_save_no_dups

setopt auto_cd
setopt multios
setopt cdablevarS

setopt extendedglob

unsetopt menu_complete
unsetopt flowcontrol
setopt auto_menu
setopt complete_in_word
setopt always_to_end

setopt auto_name_dirs
setopt auto_pushd
setopt pushd_ignore_dups

setopt long_list_jobs

# Automatically quote meta-characters like question marks, quotes and ampersands during typing or pasting.
autoload -U url-quote-magic
zle -N self-insert url-quote-magic

# Install proper key bindings for Home, PgDn, PgUp, etc.
bindkey -e

bindkey "\e[1~"   beginning-of-line
bindkey "\e[7~"   beginning-of-line
bindkey "\eOH"    beginning-of-line
bindkey "\e[H"    beginning-of-line

bindkey "\e[4~"   end-of-line
bindkey "\e[8~"   end-of-line
bindkey "\eOF"    end-of-line
bindkey "\e[F"    end-of-line

bindkey "\e[5~"   beginning-of-history
bindkey "\e[6~"   end-of-history

bindkey "\e[5C"   forward-word
bindkey "\e\e[C"  forward-word
bindkey "\eOc"    emacs-forward-word
bindkey "\e[1;5C" forward-word

bindkey "\e[5D"   backward-word
bindkey "\e\e[D"  backward-word
bindkey "\eOd"    emacs-backward-word
bindkey "\e[1;5D" backward-word

bindkey "\e[3~"   delete-char
bindkey "\e[2~"   quoted-insert
bindkey "^H"      backward-delete-word
bindkey '^i'      expand-or-complete-prefix

bindkey '\ew'     kill-region
bindkey -s '\el'  "ls\n"
bindkey -s '\e.'  "..\n"
bindkey '^r'      history-incremental-search-backward
bindkey "^[[5~"   up-line-or-history
bindkey "^[[6~"   down-line-or-history

bindkey '^[[A'    up-line-or-search
bindkey '^[[B'    down-line-or-search

bindkey "^[[H"    beginning-of-line
bindkey "^[[1~"   beginning-of-line
bindkey "^[[F"    end-of-line
bindkey "^[[4~"   end-of-line
bindkey ' '       magic-space

bindkey "^[m"     copy-prev-shell-word

# Fancy terminal title
function title {
  if [[ "$TERM" == screen* ]] || [[ "$ALTTERM" == screen* ]]; then
    print -nR $'\ek'$*$'\e\\'
  elif [[ "$TERM" == xterm* ]] || [[ "$TERM" == rxvt* ]]; then
    print -nR $'\033]0;'$*$'\a'
  fi
}

function chpwd {
  echo "$( pwd -P )" > "$ZSH/.last_directory"
}

function precmd {
  title zsh "$PWD"
  if declare -f _z > /dev/null; then
    _z --add "$( pwd -P )"
  fi
}

function preexec {
  emulate -L zsh
  local -a cmd; cmd=(${(z)1})
  title $cmd[1]:t "$cmd[2,-1]"
}

# set PATH so it includes user's private bin if it exists.
[ -d "$HOME/bin" ] && PATH="$HOME/bin:$PATH"

# This loads RVM into a shell session.
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"

# Source machine-specific local configuration file.
LOCALRC=$( echo ".localrc_`uname -n`_`uname -o`" | tr '[A-Z]' '[a-z]' | tr '/' '_' )
[[ -s "$HOME/$LOCALRC" ]] && source "$HOME/$LOCALRC"

# Enable Ctrl-X-e to edit command line in $EDITOR.
autoload -U edit-command-line
zle -N edit-command-line
bindkey '^xe' edit-command-line

# Restore last working directory if there is another Zsh instance running.
if [ -f "$ZSH/.last_directory" ]; then
  if [ $( ps a | grep '[z]sh' | wc -l ) -gt 1 ]; then
    ZSH_LAST_DIRECTORY="$( cat "$ZSH/.last_directory" )"
    [[ -d "$ZSH_LAST_DIRECTORY" ]] && cd "$ZSH_LAST_DIRECTORY"
    unset ZSH_LAST_DIRECTORY
  else
    rm "$ZSH/.last_directory"
  fi
fi

# Load all Zsh scripts in no particular order.
for __script in "$ZSH/scripts/"**/*.sh; do
  source "$__script"
done
