#-----------------------------------------------------------------------------#
# host2ip & ip2host: convert ip to hostname and vice versa
host2ip()
{
  host $1 | awk '{print $NF}' | sed 's/\.$//g'
}
ip2host()
{
  host2ip $1
}
