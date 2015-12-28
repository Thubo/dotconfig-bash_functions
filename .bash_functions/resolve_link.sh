#-----------------------------------------------------------------------------#
# resolve_link: Resolve any link back to its original source
resolve_link()
{
  $(type -p greadlink readlink | head -1) "$1"
}
