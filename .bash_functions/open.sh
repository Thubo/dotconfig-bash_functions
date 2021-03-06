# -------------------------------------------------------------------
# `o`: with no arguments opens current directory, otherwise opens the given
# location
o()
{
  local openCommand=""
  if xdg-open --version /dev/null > /dev/null 2>&1; then
    openCommand=xdg-open
  elif open --version /dev/null > /dev/null 2>&1; then
    openCommand=open
  fi
  if [ $# -eq 0 ]; then
    $openCommand .
  else
    $openCommand "$@"
  fi
}
