#!/bin/bash

VALUES=(                    \
  name     'Name'           \
  email    'E-mail address' \
  username 'GitHub name'    \
  token    'GitHub token'   \
)
TEMPLATED=(   \
  .gitconfig  \
  .Xresources \
)

INSTALL_PATH="$HOME/.install_values"
INSTALL_VALUES=''

SED_SCRIPT='sed '

# Load previous install values so we could offer defaults.
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

# Store install values for next time.
echo "$INSTALL_VALUES" > "$INSTALL_PATH"

SED_SCRIPT="$SED_SCRIPT -e 's#\\\${HOME}#'"$HOME"'#g'"

for file in "${TEMPLATED[@]}"; do
  eval "$SED_SCRIPT" -i "$HOME/$file"
done

( cd "$HOME" && git submodule update --init --recursive )

if which xrdb 1>/dev/null 2>&1; then
  xrdb -merge "$HOME/.Xresources"
fi

vim -c 'BundleInstall' -c 'qa!'

echo -e "\nDone."
