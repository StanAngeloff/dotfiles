#!/bin/bash

# {{{ Templates

profile_values=( \
  name 'Name' '' \
  email 'E-mail address' '' \
  pushDefault 'Git "push.default" (use "upstream" for Git 1.8)' 'nothing' \
  username 'GitHub name' '' \
  token 'GitHub token' '' \
)
profile_templates=( \
  .gitconfig \
  .Xresources \
)

profile_previous_values="${HOME}/.install_values"
profile_new_values=''

sed_eval_script='sed '

# Load previous install values so we could offer defaults.
[ -f "$profile_previous_values" ] && source "$profile_previous_values"

for (( i = 0 ; i < ${#profile_values[@]} ; i += 3 )); do
  value_name="${profile_values[$i]}"
  value_title="${profile_values[$i + 1]}"
  value_default="${profile_values[$i + 2]}"

  value_variable="INSTALL_${value_name}"
  value_previous="${!value_variable:-${value_default}}"

  echo -n "${value_title} [${value_previous}]: "
  read "$value_variable"

  [ -z "${!value_variable}" ] && eval $value_variable=\"$value_previous\"
  profile_new_values="${profile_new_values}"$'\n'"${value_variable}='${!value_variable}'"

  sed_eval_script="${sed_eval_script} -e 's/''${value_previous}'' # \${${value_name}}\|\${${value_name}}/'""'${!value_variable}'""' # \${${value_name}}/g'"
done

# Store install values for next time.
echo "$profile_new_values" > "$profile_previous_values"

sed_eval_script="${sed_eval_script} -e 's#\\\${HOME}#${HOME}#g'"

for template in "${profile_templates[@]}"; do
  eval "$sed_eval_script" -i "${HOME}/${template}"
done

# }}}

# {{{ Modules/Git, plug-ins, etc.

( cd "$HOME" && git submodule update --init --recursive )

# }}}

# {{{ Resources

if which xrdb &>/dev/null; then
  xrdb -merge "${HOME}/.Xresources"
fi

# }}}

# {{{ Editors/Vim

vim -c 'silent! BundleClean!'  -c 'qa!'
vim -c 'silent! BundleInstall!' -c 'qa!'

# }}}

echo -e "\nDone."
