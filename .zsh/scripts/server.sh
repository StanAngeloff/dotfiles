# Start an HTTP server from a directory, optionally specifying the port (default 3030).

function server() {
  local port="${1:-3030}"
  x-www-browser "http://127.0.0.1:${port}/"
  python -m 'SimpleHTTPServer' "$port"
}
