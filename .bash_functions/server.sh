#-----------------------------------------------------------------------------#
# server: Start an HTTP server from a directory, optionally specifying the port
server()
{
  local free_port=$(netstat_free_local_port)
  local port="${1:-${free_port}}"

  # sleep 1 && o "http://localhost:${port}/" &

  echo "Serving at..."
  echo " ->  http://127.0.0.1:${port}"
  for ip in $(myip); do
    echo " ->  http://${ip}:${port}"
  done

  # Set the default Content-Type to `text/plain` instead of `application/octet-stream`
  # And serve everything as UTF-8 (although not technically correct, this doesn’t break anything for binary files)
  python -c $'import SimpleHTTPServer;\nmap = SimpleHTTPServer.SimpleHTTPRequestHandler.extensions_map;\nmap[""] = "text/plain";\nfor key, value in map.items():\n\tmap[key] = value + ";charset=UTF-8";\nSimpleHTTPServer.test();' "$port"
}
