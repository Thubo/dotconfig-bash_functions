#-----------------------------------------------------------------------------#
# h: Search in your history
h()
{
  if [ -z "$1" ]
  then
    history
  else
    # history | grep "$@"
    history | sed 's/^ *[0-9]* *//' | cat $HISTFILE - | grep $@
  fi
}
