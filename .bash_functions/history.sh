#-----------------------------------------------------------------------------#
# h: Search in your history
h()
{
  if [ -z "$1" ]
  then
    history
  else
    # history | grep "$@"
    # history | sed 's/^ *[0-9]* *//' | cat $HISTFILE - | grep "$@"
    hist=$(history | sed 's/^ *[0-9]* *//' | cat $HISTFILE -)
    for string in "$@"; do
      hist=$(echo "$hist" | grep $string)
    done
    echo "$hist"
  fi
}
