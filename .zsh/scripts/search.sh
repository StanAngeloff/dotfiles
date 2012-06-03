function search() {
  local search_locale
  local search_query
  local search_path
  local temporary

  if [ $# -eq 1 ]; then
    search_query="$1"
    search_path="."
    shift
  elif [ $# -gt 1 ]; then
    search_query="$1"
    shift
    search_path="$1"
    shift
  else
    echo 'Usage: '"$0"' PATTERN PATH [OPTIONS...]'
    return
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
    --exclude-dir='.git'        \
    --exclude-dir='.hg'         \
    --exclude-dir='.svn'        \
    --exclude-dir='.sass-cache' \
    "\$@"                       \
    "\$search_query"            \
    "\${search_path:-.}"        \
    2>/dev/null
}
