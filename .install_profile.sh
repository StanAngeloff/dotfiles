#!/bin/bash

VALUES=(
  name 'Name'
  email 'E-mail address'
  username 'Github name'
  token 'Github token'
)
TEMPLATES=( .gitconfig )

INSTALL_PATH="$HOME/.install_values"
INSTALL_VALUES=''

SED_SCRIPT='sed '

[ -f "$INSTALL_PATH" ] && source "$INSTALL_PATH"

for (( i = 0 ; i < ${#VALUES[@]} ; i += 2 )); do
  NAME="${VALUES[$i]}"
  DESCRIPTION="${VALUES[$i + 1]}"
  VALUE="INSTALL_$NAME"
  PREVIOUS="${!VALUE}"
  echo -n "Please enter your $DESCRIPTION [$PREVIOUS]: "
  read "$VALUE"
  [ -z "${!VALUE}" ] && eval $VALUE=\"$PREVIOUS\"
  INSTALL_VALUES="$INSTALL_VALUES"$'\n'"$VALUE='${!VALUE}'"
  SED_SCRIPT="$SED_SCRIPT -e 's/''$PREVIOUS'' # \${$NAME}\|\${$NAME}/'""'${!VALUE}'""' # \${$NAME}/g'"
done

echo "$INSTALL_VALUES" > "$INSTALL_PATH"

for file in $TEMPLATES; do
  eval "$SED_SCRIPT" -i "$file"
done

URXVT_LIB_PATH="$HOME/.URxvt"
URXVT_LIBS=(
  'git://github.com/muennich/urxvt-perls.git'
  'git://github.com/stepb/urxvt-tabbedex.git'
  'git://github.com/ervandew/vimfiles.git'
)
for (( i = 0 ; i < ${#URXVT_LIBS[@]} ; i += 1 )); do
  LIB_URI="${URXVT_LIBS[$i]}"
  LIB_BASENAME="$(basename "$LIB_URI" | sed  -e 's/^urxvt-//' -e 's/.git$//')"
  if [ -d "$URXVT_LIB_PATH/$LIB_BASENAME" ]; then
   cd "$URXVT_LIB_PATH/$LIB_BASENAME" && git fetch --all && git reset --hard origin/master
  else
    git clone "$LIB_URI" "$URXVT_LIB_PATH/$LIB_BASENAME"
  fi
done

sed -e 's#${HOME}#'"$HOME"'#g' -i "$HOME/.Xdefaults"

xrdb -merge "$HOME/.Xdefaults"

VUNDLE_PATH="$HOME/.vim/bundle/vundle"
if [ -d "$VUNDLE_PATH" ]; then
  cd "$VUNDLE_PATH" && git fetch --all && git reset --hard origin/master
else
  git clone git://github.com/gmarik/vundle.git "$VUNDLE_PATH"
fi

vim -c BundleInstall -c q

( mkdir -p ~/.vim/ftdetect && cd ~/.vim/ftdetect && ln -sf ../bundle/vim-task/ftdetect/task.vim task.vim )

echo -e "\nDone."
