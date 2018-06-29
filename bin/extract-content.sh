#!/usr/bin/bash

help () {
  echo -e "\n  usage: ${0} <xml-schema-file> <saxon-jar-file> <xsl-file>\n"
  echo -e "    * output may be directed to a file when running stand-alone\n"
}

XML_SCHEMA_DEFAULT=""
XML_TRANSFORMER_DEFAULT="/opt/saxonica/SaxonEE9-7-0-18J/saxon9ee.jar"
XSL_DEFAULT="./lib/extract-xml-schema-content.xsl.sef"
if [ ${#} -eq 3 ] ; then
  XML_SCHEMA_ARG=${1}
  XML_TRANSFORMER_ARG=${2}
  XSL_ARG=${3}
  if [ -n "${XML_SCHEMA_ARG}" ]; then
    XML_SCHEMA=${XML_SCHEMA_ARG};
  else
    XML_SCHEMA=${XML_SCHEMA_DEFAULT};
  fi
  if [ -n "${XML_TRANSFORMER_ARG}" ]; then
    XML_TRANSFORMER=${XML_TRANSFORMER_ARG};
  else
    XML_TRANSFORMER=${XML_TRANSFORMER_DEFAULT};
  fi
  if [ -n "${XSL_ARG}" ]; then
    XSL=${XSL_ARG};
  else
    XSL=${XSL_DEFAULT};
  fi
  if [ -f ${XML_SCHEMA} ] ; then
    if [ -f ${XML_TRANSFORMER} ] ; then
      java -jar "${XML_TRANSFORMER}" -xsl:"${XSL}" -s:"${XML_SCHEMA}"
    else
      echo -e "\n  file does not exist: ${XML_TRANSFORMER}\n"
    fi
  else
    echo -e "\n  file does not exist: ${XML_SCHEMA}\n" 
  fi
else
  help
fi
