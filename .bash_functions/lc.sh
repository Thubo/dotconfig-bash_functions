#-----------------------------------------------------------------------------#
# lc: Convert the parameters or STDIN to lowercase.
lc()
{
  if [ $# -eq 0 ]; then
    tr '[:upper:]' '[:lower:]'
  else
    tr '[:upper:]' '[:lower:]' <<< "$@"
  fi
}
