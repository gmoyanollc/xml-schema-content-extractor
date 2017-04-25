#!/usr/bin/bash
# execute from project base
SOURCE_XML_BASE="./input/"
if [ ${#} -eq 1 ] ; then
  if [ -f ${SOURCE_XML_BASE}${1} ] ; then
    java -jar /opt/saxonica/SaxonEE9-7-0-18J/saxon9ee.jar -xsl:./lib/extract-xml-schema-documentation.sef -s:${SOURCE_XML_BASE}${1}
    else
      echo "  file does not exist: ${SOURCE_XML_BASE}${1}" 
  fi
else
  echo "  missing argument: ${0} [xml-file-name-with-path-relevant-to-base:${SOURCE_XML_BASE}]"
fi
