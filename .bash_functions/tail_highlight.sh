#-----------------------------------------------------------------------------#
# tail with search highlight
#
# usage: t /var/log/Xorg.0.log [kHz]
t()
{
  if [ $# -eq 0 ]; then
    echo "Usage: t /var/log/Xorg.0.log [kHz]"
    return 1
  else
    if [ $2 ]; then
      tail -n 50 -f $1 | perl -pe "s/$2/\e[1;32;40m$&\e[0m/g"
    else
      tail -n 50 -f $1
    fi
  fi
}
