#-----------------------------------------------------------------------------#
# pretty_json: Make JSON output pretty
pretty_json()
{
  python -m json.tool
}

#-----------------------------------------------------------------------------#
# pretty_xml: Make JSON output pretty
pretty_xml()
{
  xmllint --format -
}
