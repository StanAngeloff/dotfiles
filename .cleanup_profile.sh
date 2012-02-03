#!/bin/bash

PURGE_DAYS=60
TARGETS=( \
  .vim/undo \
  .vim/backup \
)

for directory in "${TARGETS[@]}"; do
  find "$directory" -mtime +$PURGE_DAYS -exec rm -f {} \;
done
