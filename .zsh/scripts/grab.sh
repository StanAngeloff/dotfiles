function grab() {
  local uri
  uri="$1"
  shift
  if [[ ! "$uri" =~ ^[a-z]\+:// ]]; then
    uri="http://${uri}"
  fi
  wget                         \
    --no-clobber               \
    --progress=bar             \
    --restrict-file-names=unix \
    --recursive                \
    --no-check-certificate     \
    --convert-links            \
    --page-requisites          \
    --no-parent                \
    --adjust-extension         \
    --domains "$( echo "$uri" | awk -F/ '{ print $3 }' )" \
    "$@" "$uri"
}
