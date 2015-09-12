#-----------------------------------------------------------------------------#
# myip: return my own ips
myip()
{
  ip addr | grep "inet " | grep -v 127 | cut -d / -f1 | awk '{print $2}'
}
