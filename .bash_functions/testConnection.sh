#-----------------------------------------------------------------------------#
# testConnection: check if connection to google.com is possible
#
# usage:
#   testConnection 1  # will echo 1 || 0
#   testConnection    # will return 1 || 0
testConnection()
{
  local target="www.google.com"

  if [[ ! -z $1 ]]; then
    local target=$1
  fi

  if type curl >/dev/null 2>&1 ; then
    command="curl -k --silent $target"
  elif type wget >/dev/null 2>&1 ; then
    command="wget --no-check-certificate --tries=2 --timeout=2 $target -qO-"
  else
    echo "Neither wget nor curl installed - Exit!"
    exit 1
  fi

  if $command &>/dev/null 2>&1; then
    return 0
  else
    return 1
  fi

}
