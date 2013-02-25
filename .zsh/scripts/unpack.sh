# Idea from https://github.com/yomi322/config/blob/master/dot.zshrc

function unpack() {
  if [ $# -lt 1 ]; then
    echo 'Usage: '"$0"' FILE [DIRECTORY]' >/dev/stderr
    return 1
  fi
  local file
  local directory
  local command
  file="$( readlink -f "$1" )"
  directory="${2:-.}"
  case "$file" in
    *.tar.gz  | *.tgz  ) command='tar -zxvf' ;;
    *.tar.bz2 | *.tbz2 ) command='tar -jxvf' ;;
    *.tar.xz           ) command='tar -Jxvf' ;;
    *.tar              ) command='tar -xvf'  ;;
    *.zip              ) command='unzip'     ;;
    *.gzip  | *.gz     ) command='gunzip'    ;;
    *.bzip2 | *.bz2    ) command='bunzip2'   ;;
    * )
      echo "$0: Unsupported file format: $file" >/dev/stderr ;
      return 2
      ;;
  esac
  ( cd "$directory" && eval $command "\$file" )
}
