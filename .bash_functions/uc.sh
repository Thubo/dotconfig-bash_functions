#-----------------------------------------------------------------------------#
# uc: Convert the parameters or STDIN to uppercase.
uc()
{
  if [ $# -eq 0 ]; then
    tr '[:lower:]' '[:upper:]'
  else
    tr '[:lower:]' '[:upper:]' <<< "$@"
  fi
}
