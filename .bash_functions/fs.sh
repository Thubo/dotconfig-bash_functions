#-----------------------------------------------------------------------------#
# fs: Determine size of a file or total size of a directory
fs()
{
  if [[ -z "$@" ]]; then
    du -sh .[^.]* * | sort -h
  else
    du -sh -- "$@"
  fi
}

#-----------------------------------------------------------------------------#
# dus: Determine the size of all non-hidden files in the current dir and sort them
dus()
{
  if [[ -z "$@" ]]; then
    du -sh * | sort -h
  else
    du -sh -- "$@" | sort -h
  fi
}

#-----------------------------------------------------------------------------#
# das: Determine the size of all hidden files in the current dir and sort them
das()
{
  if [[ -z "$@" ]]; then
    find . -maxdepth 1 -name ".?*" | xargs du -sch | sort -h
  else
    du "$@" -sh | sort -h
  fi
}
