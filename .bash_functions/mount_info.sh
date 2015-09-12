#-----------------------------------------------------------------------------#
# nice mount (http://catonmat.net/blog/another-ten-one-liners-from-commandlingfu-explained)
#
# displays mounted drive information in a nicely formatted manner
mount_info()
{
  (echo "DEVICE PATH TYPE FLAGS" && mount | awk '$2="";1') \
    | column -t;
}
