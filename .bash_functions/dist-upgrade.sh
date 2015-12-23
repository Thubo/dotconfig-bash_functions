#-----------------------------------------------------------------------------#
# dist-upgrade: update your os
dist-upgrade()
{
  minutes_since_last_update=$((($(date +%s)-$(stat -c %Y /var/lib/apt/periodic/update-success-stamp))/60))

  if [[ $minutes_since_last_update -gt 60 ]]; then
    echo -n "Getting package information..."
    sudo apt-get -qqq update
    echo "Done!"
  else
    echo "Assuming package information is up-to-date!"
  fi

  sudo apt-get -y dist-upgrade
  sudo apt-get -y autoremove
  alert

}
