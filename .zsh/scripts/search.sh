function search() {
  local search_locale
  local search_query
  local search_path
  local search_args
  local method
  local temporary

  if [ $# -lt 1 ]; then
    echo 'Usage: '"$0"' PATTERN PATH [OPTIONS...]'
    return 1
  fi

  # Query always comes first.
  search_query="$1"
  shift

  # If any of the following arguments starts with a '+' or '-',
  # it is considered an include/exclude extension.
  while [[ "${1:0:1}" == '+' ]] || [[ "${1:0:1}" == '-' ]]; do
    if  [[ "${1:0:1}" == '+' ]]; then method='include' fi
    if  [[ "${1:0:1}" == '-' ]]; then method='exclude' fi
    search_args="$search_args --$method='*.${1:1}'"
    shift
  done

  # Directory (path) to search always comes last.
  if [ $# -gt 0 ]; then
    search_path="$1"
    shift
  fi

  # > Using LC_CTYPE=POSIX instead of UTF-8 speeds up my grep by a factor of 27.
  # > Log file greppers of the world, take note.
  #
  # https://twitter.com/jlaurila/status/86750682094374912
  temporary="$( mktemp -t detect-XXXXXXXX )"
  echo "$search_query" > "$temporary"
  if file -bi "$temporary" | grep -qi 'ascii'; then
    search_locale='LC_CTYPE=POSIX'
  else
    search_locale=''
  fi
  rm -f "$temporary"

  eval "$search_locale"         \
  grep -Ri                      \
    --color=always              \
    --line-number               \
    --binary-file=without-match \
        --exclude='.tags'       \
    --exclude-dir='.git'        \
    --exclude-dir='.hg'         \
    --exclude-dir='.svn'        \
    --exclude-dir='.sass-cache' \
    "$search_args"              \
    "\$@"                       \
    "\$search_query"            \
    "\${search_path:-.}"        \
    2>/dev/null
}