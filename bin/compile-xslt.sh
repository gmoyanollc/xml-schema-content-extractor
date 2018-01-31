#!/usr/bin/bash
# 
# run from project root folder
#
XML_TRANSFORMER="/opt/saxonica/SaxonEE9-7-0-18J/saxon9ee.jar"
if [ ${#} -eq 1 ] ; then
  XSL_FILE_ARG=${1}
  echo XSL_FILE_ARG=${XSL_FILE_ARG}
  echo XML_TRANSFORMER=${XML_TRANSFORMER}
  if [ -n "${XSL_FILE_ARG}" ]; then
    XSL=${XSL_FILE_ARG};
    if [ -n "${XML_TRANSFORMER}" ]; then
      #java -jar /opt/saxonica/SaxonEE9-7-0-18J/saxon9ee.jar -xsl:./lib/extract-xml-schema-documentation.xsl -export:./lib/extract-xml-schema-documentation.sef -nogo
      java -jar "${XML_TRANSFORMER}" -xsl:"${XSL}" -export:"${XSL}".sef -nogo
      echo -e "\n  done..compiled to ${XSL}.sef\n"
    else
      echo -e "\n  file does not exist: ${XML_TRANSFORMER}\n"
    fi
  else
     echo -e "\n  file does not exist: ${XSL_FILE_ARG}\n"
  fi
else
  echo -e "\n  usage: ${0} xsl-file\n"
fi

