#-----------------------------------------------------------------------------#
# wtfis: Show what a given command really is. It is a combination of "type", "file"
# and "ls". Unlike "which", it does not only take $PATH into account. This
# means it works for aliases and hashes, too. (The name "whatis" was taken,
# and I did not want to overwrite "which", hence "wtfis".)
# The return value is the result of "type" for the last command specified.
#
# usage:
#
#   wtfis man
#   wtfis vi
#
# source: https://raw.githubusercontent.com/janmoesen/tilde/master/.bash/commands
wtfis()
{
  local cmd=""
  local type_tmp=""
  local type_command=""
  local i=1
  local ret=0

  if [ -n "$BASH_VERSION" ]; then
    type_command="type -p"
  else
    type_command=( whence -p ) # changes variable type as well
  fi

  if [ $# -eq 0 ]; then
    # Use "fc" to get the last command, and use that when no command
    # was given as a parameter to "wtfis".
    set -- $(fc -nl -1)

    while [ $# -gt 0 -a '(' "sudo" = "$1" -o "-" = "${1:0:1}" ')' ]; do
      # Ignore "sudo" and options ("-x" or "--bla").
      shift
    done

    # Replace the positional parameter array with the last command name.
    set -- "$1"
  fi

  for cmd; do
    type_tmp="$(type "$cmd")"
    ret=$?

    if [ $ret -eq 0 ]; then
      # Try to get the physical path. This works for hashes and
      # "normal" binaries.
      local path_tmp=$(${type_command} "$cmd" 2> /dev/null)

      if (( $? )) || ! test -x $path_tmp; then
        # Show the output from "type" without ANSI escapes.
        echo "${type_tmp//$'\e'/\\033}"

        case "$(command -v "$cmd")" in
          'alias')
            local alias_="$(alias "$cmd")"

            # The output looks like "alias foo='bar'" so
            # strip everything except the body.
            alias_="${alias_#*\'}"
            alias_="${alias_%\'}"

            # Use "read" to process escapes. E.g. 'test\ it'
            # will # be read as 'test it'. This allows for
            # spaces inside command names.
            read -d ' ' alias_ <<< "$alias_"

            # Recurse and indent the output.
            # TODO: prevent infinite recursion
            wtfis "$alias_" 2>&2 | sed 's/^/  /'

            ;;
          'keyword' | 'builtin')

            # Get the one-line description from the built-in
            # help, if available. Note that this does not
            # guarantee anything useful, though. Look at the
            # output for "help set", for instance.
            help "$cmd" 2> /dev/null | {
              local buf line
              read -r line
              while read -r line; do
                buf="$buf${line/.  */.} "
                if [[ "$buf" =~ \.\ $ ]]; then
                  echo "$buf"
                  break
                fi
              done
            }

            ;;
        esac
      else
        # For physical paths, get some more info.
        # First, get the one-line description from the man page.
        # ("col -b" gets rid of the backspaces used by OS X's man
        # to get a "bold" font.)
        (COLUMNS=10000 man "$(basename "$path_tmp")" 2>/dev/null) | col -b | \
        awk '/^NAME$/,/^$/' | {
          local buf=""
          local line=""

          read -r line
          while read -r line; do
            buf="$buf${line/.  */.} "
            if [[ "$buf" =~ \.\ $ ]]; then
              echo "$buf"
              buf=''
              break
            fi
          done

          [ -n "$buf" ] && echo "$buf"
        }

        # Get the absolute path for the binary.
        local full_path_tmp="$(
          cd "$(dirname "$path_tmp")" \
            && echo "$PWD/$(basename "$path_tmp")" \
            || echo "$path_tmp"
        )"

        if [ -d $full_path_tmp ]; then
          type $cmd
        else
          # Then, combine the output of "type" and "file".
          local fileinfo="$(file "$full_path_tmp")"
          echo "${type_tmp%$path_tmp}${fileinfo}"

          # Finally, show it using "ls" and highlight the path.
          # If the path is a symlink, keep going until we find the
          # final destination. (This assumes there are no circular
          # references.)
          local paths_tmp=("$path_tmp")
          local target_path_tmp="$path_tmp"

          while [ -L "$target_path_tmp" ]; do
            target_path_tmp="$(readlink "$target_path_tmp")"
            paths_tmp+=("$(
              # Do some relative path resolving for systems
              # without readlink --canonicalize.
              cd "$(dirname "$path_tmp")"
              cd "$(dirname "$target_path_tmp")"
              echo "$PWD/$(basename "$target_path_tmp")"
            )")
          done

          local ls="$(command ls -fdalF "${paths_tmp[@]}")"
          echo "${ls/$path_tmp/$'\e[7m'${path_tmp}$'\e[27m'}"
        fi
      fi
    fi

    # Separate the output for all but the last command with blank lines.
    [ $i -lt $# ] && echo
    let i++
  done

  return $ret
}
