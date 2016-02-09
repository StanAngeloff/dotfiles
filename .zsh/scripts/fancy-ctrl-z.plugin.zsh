# See https://github.com/robbyrussell/oh-my-zsh/blob/5464fe3e/plugins/fancy-ctrl-z/fancy-ctrl-z.plugin.zsh
fancy-ctrl-z () {
  if [[ $#BUFFER -eq 0 ]]; then
    BUFFER="fg"
    zle accept-line
  else
    zle push-input
    BUFFER="fg"
    zle accept-line
  fi
}
zle -N fancy-ctrl-z
bindkey '^Z' fancy-ctrl-z
