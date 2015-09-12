#-----------------------------------------------------------------------------#
# connection_overview: get stats-overview about your connections
netstat_connection_overview()
{
  (echo "#Count #Status" && \
   netstat -nat \
    | grep tcp \
    | awk '{print $6}' \
    | sort \
    | uniq -c \
    | sort -n) | column -t
}
