# git-freeze: take the current index and working tree state and "freeze" them
#   by creating a commit for each as necessary
#
# git-thaw: look for commits created by git-freeze and restore them to
#   working tree or index as appropriate

# alias gf='git-freeze'
# alias gt='git-thaw'

function git-freeze () {
  local count=0
  if git commit -m "WIP [STAGED]" > /dev/null
    then
      let count+=1
  fi
  git add --all .
  if git commit -am "WIP [UNSTAGED]" > /dev/null
    then
      let count+=1
  fi
  if [ $count -eq 0 ]
    then
      echo "nothing committed"
  else
      git --no-pager log -n$count --pretty=format:'%Cgreen%h %Cred%an%Creset: %s'
  fi
}

function git-thaw () {
  if git rev-list HEAD -n1 --pretty="format:%s" | tail -n1 | grep "^WIP \[UNSTAGED\]$" > /dev/null
    then
      git reset HEAD^ > /dev/null
  fi
  if git rev-list HEAD -n1 --pretty="format:%s" | tail -n1 | grep "^WIP \[STAGED\]$" > /dev/null
    then
      git reset --soft HEAD^ > /dev/null
  fi
  git status --short
}
