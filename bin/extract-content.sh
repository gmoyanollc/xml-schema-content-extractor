#!/usr/bin/bash
# execute from project base
#SOURCE_XML_BASE="/home/g/g-dev/soi-messaging/tsoa-track/src/main/resources/iep-schema/"
if [ ${#} -eq 1 ] ; then
  if [ -f ${SOURCE_XML_BASE}${1} ] ; then
    java -jar /opt/saxonica/SaxonEE9-7-0-18J/saxon9ee.jar -xsl:./lib/extract-xml-schema-documentation.sef -s:${SOURCE_XML_BASE}${1}
  else
    echo "  file does not exist: ${SOURCE_XML_BASE}${1}" 
  fi
else
  echo -e "  usage: ${0} xml-schema-file"
fi
