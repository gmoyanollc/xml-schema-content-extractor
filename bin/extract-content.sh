#!/usr/bin/bash
# execute from project base

XML_SCHEMA_CONST=""
XML_TRANSFORMER="/opt/saxonica/SaxonEE9-7-0-18J/saxon9ee.jar"
XSL="./lib/extract-xml-schema-content.xsl.sef"
#echo "XML_TRANSFORMER: ${XML_TRANSFORMER}"
#echo "XSL: ${XSL}"
if [ ${#} -eq 1 ] ; then
  XML_SCHEMA_ARG=${1}
  if [ -n "${XML_SCHEMA_ARG}" ]; then
    XML_SCHEMA=${XML_SCHEMA_ARG};
  else
    XML_SCHEMA=${XML_SCHEMA_CONST};
  fi
  #echo "XML_SCHEMA: ${XML_SCHEMA}"
  # output is directed to console and may be directed to a file
  #CONTENT_OUTPUT_DIR_ARG=${2}
  #if [ -n "${CONTENT_OUTPUT_DIR_ARG}" ]; then
  #  CONTENT_OUTPUT_DIR=${CONTENT_OUTPUT_DIR_ARG};
  #else
  #  CONTENT_OUTPUT_DIR=${CONTENT_OUTPUT_DIR_CONST};
  #fi
  #echo "CONTENT_OUTPUT_DIR: ${CONTENT_OUTPUT_DIR}"
  if [ -f ${XML_SCHEMA} ] ; then
    #java -jar ${XML_TRANSFORMER} -xsl:./lib/extract-xml-schema-documentation.sef -s:${XML_SCHEMA}
    java -jar "${XML_TRANSFORMER}" -xsl:"${XSL}" -s:"${XML_SCHEMA}"
  else
    echo -e "\n  file does not exist: ${XML_SCHEMA}\n" 
  fi
else
  echo -e "\n  usage: ${0} xml-schema-file\n"
fi
