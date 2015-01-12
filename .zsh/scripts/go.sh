# Go Binary Distribution Notes
#
# See `umake go --help`
# See /opt/tools/go/go-lang/README

if [[ -d /opt/tools/go/go-lang ]]; then
  export GOROOT=/opt/tools/go/go-lang
  export PATH="$PATH":"$GOROOT"/bin
fi
