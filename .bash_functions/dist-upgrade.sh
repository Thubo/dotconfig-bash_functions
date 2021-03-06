#-----------------------------------------------------------------------------#
# dist-upgrade: update your os
dist-upgrade()
{
  if [[ -f /var/lib/apt/periodic/update-success-stamp ]]; then
    minutes_since_last_update=$((($(date +%s)-$(stat -c %Y /var/lib/apt/periodic/update-success-stamp))/60))
  else
    minutes_since_last_update=61
  fi

  if [[ $minutes_since_last_update -gt 60 ]]; then
    echo -n "Getting package information..."
    sudo apt-get -qqq update
    echo "Done"
  else
    echo "Assuming package information is up-to-date!"
  fi

  sudo apt-get -y dist-upgrade
  sudo apt-get -y autoremove
}
