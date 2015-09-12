#-----------------------------------------------------------------------------#
# givedef: shell function to define words
# http://vikros.tumblr.com/post/23750050330/cute-little-function-time
givedef()
{
  if [ $# -ge 2 ]; then
    echo "givedef: too many arguments" >&2
    return 1
  else
    curl --silent "dict://dict.org/d:$1"
  fi
}
