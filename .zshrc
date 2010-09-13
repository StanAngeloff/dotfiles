#!/bin/zsh

umask 022

ZSH=~/.zsh

HISTSIZE=1024
SAVEHIST=$HISTSIZE
HISTFILE="$ZSH/history"

PATH=/usr/local/bin:/usr/bin:/bin:/cygdrive/c/Program\ Files\ \(x86\)/Java/jdk1.6.0_20/bin:/cygdrive/c/Program\ Files\ \(x86\)/WinAnt/bin

export NODE_PATH="/home/stan/.coffee_libraries:$NODE_PATH"
export EDITOR=vim

export GREP_OPTIONS='--color=auto'
export GREP_COLOR='1;32'

export PAGER=less
export LC_CTYPE=en_US.UTF-8

autoload colors; colors;
export LSCOLORS="Gxfxcxdxbxegedabagacad"
export PROMPT="%{$fg[green]%}(%n)%{$reset_color%} %{$fg[yellow]%}[%1~]%{$reset_color%} %# "

alias ssh_bg='TODO:ssh command'

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

setopt prompt_subst

alias ll='ls -hal --color=tty'
alias pu='pushd'
alias po='popd'
alias .='pwd'
alias ...='cd ../..'
alias -- -='cd -'

autoload -U compinit
compinit -i

zstyle ':completion:*:descriptions' format '%U%B%d%b%u'
zstyle ':completion:*:warnings' format '%BSorry, no matches for: %d%b'
zstyle ':completion:*:*:*:*:*' menu select
zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#) ([0-9a-z-]#)*=01;34=0=01'
zstyle ':completion:*:*:*:*:processes' command "ps -u `whoami` -o pid,user,comm -w -w"
zstyle ':completion:*' list-colors ''
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path ~/.zsh/cache

if [ -f ~/.ssh/known_hosts ]; then
  zstyle ':completion:*' hosts $( sed 's/[, ].*$//' $HOME/.ssh/known_hosts )
  zstyle ':completion:*:*:(ssh|scp):*:*' hosts `sed 's/^\([^ ,]*\).*$/\1/' ~/.ssh/known_hosts`
fi

zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path ~/.zsh/cache

autoload -U promptinit
promptinit

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

autoload -U url-quote-magic
zle -N self-insert url-quote-magic

alias ..='cd ..'
alias cd..='cd ..'
alias cd...='cd ../..'
alias cd....='cd ../../..'
alias cd.....='cd ../../../..'
alias cd/='cd /'

alias 1='cd -'
alias 2='cd +2'
alias 3='cd +3'
alias 4='cd +4'
alias 5='cd +5'
alias 6='cd +6'
alias 7='cd +7'
alias 8='cd +8'
alias 9='cd +9'

cd () {
  if   [[ "x$*" == "x..." ]]; then
    cd ../..
  elif [[ "x$*" == "x...." ]]; then
    cd ../../..
  elif [[ "x$*" == "x....." ]]; then
    cd ../../..
  elif [[ "x$*" == "x......" ]]; then
    cd ../../../..
  else
    builtin cd "$@"
  fi
}

alias md='mkdir -p'
alias rd=rmdir

alias d='dirs -v'

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

source ~/.zsh/jump_shell_driver
alias ju=jump

