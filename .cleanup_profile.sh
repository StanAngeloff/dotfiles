#!/usr/bin/env bash

purge_days=60
targets=( \
  '.vim/undo' \
  '.vim/backup' \
  '.vim/view' \
)

action='-delete'
if which trash 1>/dev/null 2>&1; then
  action='-exec trash {}'
fi

for target in "${targets[@]}"; do
  exec find "${HOME}/${target}" -mtime +$purge_days \! -name '.*' $action \;
done
