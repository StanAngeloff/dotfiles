#!/bin/zsh

# Set default file permissions for newly created files.
umask 022

# Set Zsh home directory and history file location.
# We want these out of the way an in their separate directory.
ZSH="$HOME/.zsh"
HISTFILE="$ZSH/history"

# Configure Zsh command history size.
HISTSIZE=40960
SAVEHIST=$HISTSIZE

fpath=($ZSH/functions $fpath)

# Turn on 256-colour terminal support.
export TERM=xterm-256color

# Configure preferred applications.
export EDITOR=nvim
export PAGER=less

export LESS='-iRSFX'
export LESS_TERMCAP_me=$(printf '\e[0m')
export LESS_TERMCAP_se=$(printf '\e[0m')
export LESS_TERMCAP_ue=$(printf '\e[0m')
export LESS_TERMCAP_mb=$(printf '\e[1;32m')
export LESS_TERMCAP_md=$(printf '\e[1;34m')
export LESS_TERMCAP_us=$(printf '\e[1;32m')
export LESS_TERMCAP_so=$(printf '\e[1;44;1m')


# Configure preferred language option.
export LANG="en_GB.UTF-8"
export LANGUAGE="en_GB:en_US:en"
export LC_MESSAGES="en_GB.UTF-8"

# Configure applications, e.g., grep, ack, etc.
#export GREP_OPTIONS='--color=auto'
export GREP_COLOR='1;32'

# Enable colour terminal and prompt.
autoload colors; colors;

function _user_hostname_prompt() {
  if [ -n "$SSH_CLIENT$SSH2_CLIENT$SSH_TTY" ]; then
    echo "%{$fg[white]%}%n@%{$reset_color%}%{$fg[green]%}%m:%{$reset_color%}"
  fi
}
function _root_prompt() {
  if [ $UID -eq 0 ]; then echo "%{$fg[white]%}#%{$reset_color%}"; fi
}

precmd() {
  local jobs
  # If there are suspended jobs, display the first argument of each command-line.
  #
  # See http://www.zsh.org/mla/users/2001/threads.html#00700
  if [[ "${(k)jobstates[(r)*+*]}" -gt 0 ]]; then
    jobs=' ['"${jobtexts[@]%% *}"']'
  fi
  psvar=( "$jobs" )
}

# Outputs the name of the current branch
# Usage example: git pull origin $(_git_branch)
# Using '--quiet' with 'symbolic-ref' will not cause a fatal error (128) if
# it's not a symbolic ref, but in a Git repo.
function _git_branch() {
  local ref
  ref=$(command git symbolic-ref --quiet HEAD 2> /dev/null)
  local ret=$?
  if [[ $ret != 0 ]]; then
    [[ $ret == 128 ]] && return  # no git repo.
    ref=$(command git rev-parse --short HEAD 2> /dev/null) || return
  fi
  echo ${ref#refs/heads/}
}

function _git_branch_prompt() {
  local branch=$(_git_branch)
  if [ -n "$branch" ]; then
    # See http://zsh.sourceforge.net/Doc/Release/Prompt-Expansion.html
    echo " %8F‹ $branch›%f"
  fi
}

function _docker_machine_prompt() {
  if [ -n "$DOCKER_MACHINE_NAME" ]; then
    # See http://zsh.sourceforge.net/Doc/Release/Prompt-Expansion.html
    echo " %4F🐋 machine⋯$DOCKER_MACHINE_NAME%f"
  fi
}

export PROMPT="$(_user_hostname_prompt)%{$fg[white]%}%{$reset_color%}%{$fg[yellow]%}%(!.%1~.%~)%{$reset_color%}$(_root_prompt)%{$fg[white]%}%1v%{$reset_color%}\$(_docker_machine_prompt)\$(_git_branch_prompt) %(?:→:×) " # format is 'login-name@machine-name → cwd #'

export LSCOLORS="Gxfxcxdxbxegedabagacad"

# Allow variable substitution to take place in the prompt.
setopt prompt_subst

if [[ -e "${HOME}/.asdf/asdf.sh" ]]; then
    source "${HOME}/.asdf/asdf.sh"
    fpath=(${ASDF_DIR}/completions $fpath)
fi

# Add user-completion directory to the array of Zsh sources (e.g., for improved Git).
fpath=( "${HOME}/.zsh/completions/src" $fpath )

# Configure the auto-completion system.
autoload -U compinit
compinit -i
zmodload -i zsh/complist

zstyle ':completion:*' list-colors ''
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path /tmp/.zsh/cache

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
setopt append_history
setopt extended_history
setopt hist_find_no_dups
setopt hist_ignore_dups
setopt hist_ignore_space
setopt hist_no_functions
setopt hist_no_store
setopt hist_reduce_blanks
setopt hist_save_no_dups
setopt inc_append_history
setopt no_hist_beep

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

# https://zsh.sourceforge.io/Intro/intro_16.html#IDX223
setopt interactivecomments

# See http://stackoverflow.com/a/1438523
# Stop on '/' character when deleting words using ^H.
autoload -U select-word-style
select-word-style bash

# Automatically quote meta-characters like question marks, quotes and ampersands during typing or pasting.
autoload -U url-quote-magic
zle -N self-insert url-quote-magic

# Enable Ctrl-X-e to edit command line in $EDITOR.
autoload -U edit-command-line
zle -N edit-command-line
bindkey '^xe' edit-command-line

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

# Search for a history line matching the start of the current line: {{{
#
# See https://bbs.archlinux.org/viewtopic.php?pid=1170157#p1170157

autoload up-line-or-beginning-search
autoload down-line-or-beginning-search

zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search

[[ -n "${key[Up]}" ]] && bindkey "${key[Up]}" up-line-or-beginning-search
[[ -n "${key[Down]}" ]] && bindkey "${key[Down]}" down-line-or-beginning-search

# }}}

bindkey "^[[H"    beginning-of-line
bindkey "^[[1~"   beginning-of-line
bindkey "^[[F"    end-of-line
bindkey "^[[4~"   end-of-line
bindkey ' '       magic-space

bindkey "^[m"     copy-prev-shell-word

# Load Zsh scripts in no particular order.
for __script in "$ZSH/scripts/"**/*.*sh(N); do
  if [ -f "$__script" ]; then
    source "$__script"
  fi
done

unset __path
unset __script

# Use a separate file to configure command aliases.
[[ -s "$HOME/.aliases" ]] && source "$HOME/.aliases"

# See https://gpgtools.tenderapp.com/kb/faq/enter-passphrase-with-pinentry-in-terminal-via-ssh-connection
#
export GPG_TTY=$(tty)
if [[ -n "$SSH_CONNECTION" ]]; then
    export PINENTRY_USER_DATA="USE_CURSES=1"
fi

export RIPGREP_CONFIG_PATH="${HOME}/.rgrc"

if [[ -f ~/.fzf.zsh ]]; then
    source ~/.fzf.zsh

    export FZF_DEFAULT_COMMAND='rg --files'
    export FZF_DEFAULT_OPTS="--color=bw --layout=reverse --info=inline --no-separator --prompt='→ ' --marker='×' --pointer='▶' --ellipsis='…' --bind 'ctrl-f:page-down,ctrl-b:page-up,ctrl-d:half-page-down,ctrl-u:half-page-up' --color='prompt:244,pointer:244,marker:201'"
fi

# # bat {{{1
#

export BAT_CONFIG_PATH="${HOME}/.bat.conf"
export BAT_THEME=base16

# ## man
#
# `bat` can be used as a colorizing pager for `man`, by setting the `MANPAGER` environment variable:
if _bat_path="$(type -p bat)" && [[ -n "$_bat_path" ]]; then
    export MANPAGER="sh -c 'col -bx | bat -l man -p'"
fi

# }}}1

if [[ -d "${HOME}/bin" ]]; then
  export PATH="${HOME}/bin:${PATH}"
fi
if [[ -d "${HOME}/.local/bin" ]]; then
  export PATH="${HOME}/.local/bin:${PATH}"
fi

# jump by @gsamokovarov needs to be integrated with the shell.
which jump &>/dev/null && eval "$(jump shell --bind=z)"

# git-subrepo
if [[ -d "$HOME"/bin/git-subrepo ]]; then
  source "$HOME"/bin/git-subrepo/.rc
  fpath=( "$HOME"/bin/git-subrepo/share/zsh-completion $fpath )
fi

# Source machine-specific local configuration.
LOCALRC=$( echo ".localrc_`uname -n`_`uname -o 2>/dev/null || echo Darwin`" | tr '[A-Z]' '[a-z]' | tr '/' '_' )
[ -s "$HOME/$LOCALRC" ] && source "$HOME/$LOCALRC"
