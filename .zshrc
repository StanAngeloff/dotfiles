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

# Turn on 256-colour terminal support.
[ -z "$TERM" ] || [[ "$TERM" == 'xterm' ]] && export TERM=xterm-256color

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
export PROMPT="$(_user_hostname_prompt)%{$fg[white]%}%{$reset_color%}%{$fg[yellow]%}%(!.%1~.%~)%{$reset_color%}$(_root_prompt) ➜ " # format is 'login-name@machine-name ➜ cwd #'

export LSCOLORS="Gxfxcxdxbxegedabagacad"

# Allow variable substitution to take place in the prompt.
setopt prompt_subst

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

# Add user-completion directory to the array of Zsh sources (e.g., for improved Git).
fpath=( "$HOME/.zsh/completion" $fpath )

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

bindkey '^[[A'    up-line-or-search
bindkey '^[[B'    down-line-or-search

bindkey "^[[H"    beginning-of-line
bindkey "^[[1~"   beginning-of-line
bindkey "^[[F"    end-of-line
bindkey "^[[4~"   end-of-line
bindkey ' '       magic-space

bindkey "^[m"     copy-prev-shell-word

# Expand PATH and include User binaries and {php,rb}env, if installed.
# NOTE: The order is important -- we scan PHP first and Ruby next,
#       but since we are prepending to PATH, Ruby will go in first.
for __path in "$HOME/bin" "$HOME/."{php,rb}"env/bin"; do
  [ -d "$__path" ] && export PATH="$__path:$PATH"
done

# Extend {php,rb}env with plug-ins from non-standard location.
for __path in "$HOME/."{php,rb}"env-plugins/"; do
  if [ -d "$__path" ]; then
    for __script in "$__path"*/bin(N); do
      export PATH="$__script:$PATH"
    done
    for __script in "$__path"*/etc/{php,rb}env.d(N); do
      export RBENV_HOOK_PATH="$__script:$RBENV_HOOK_PATH"
    done
  fi
done

# Add {php,rb}env to shell for shims and auto-completion.
for __script in {php,rb}env; do
  which "$__script" &>/dev/null && eval "$( "$__script" init - )"
done

# Load Zsh scripts in no particular order.
for __script in "$ZSH/scripts/"**/*.sh(N); do
  source "$__script"
done

unset __path
unset __script

# Use a separate file to configure command aliases.
[[ -s "$HOME/.aliases" ]] && source "$HOME/.aliases"

# Source machine-specific local configuration.
LOCALRC=$( echo ".localrc_`uname -n`_`uname -o`" | tr '[A-Z]' '[a-z]' | tr '/' '_' )
[ -s "$HOME/$LOCALRC" ] && source "$HOME/$LOCALRC"
