#-----------------------------------------------------------------------------#
# dist-upgrade: update your os
dist-upgrade()
{
  sudo echo 'Starting Update'
  sudo apt-get -qqq update
  sudo apt-get -y dist-upgrade
  sudo apt-get -y autoremove
  alert
}
