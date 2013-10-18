ctrlz () {
  fg
  # If we ^Z the process again, next time we return re-display the command-line.
  zle redisplay
}

zle -N ctrlz
bindkey '^Z' ctrlz
