#!/usr/bin/bash
# 
# run from project root folder
#
java -jar /opt/saxonica/SaxonEE9-7-0-18J/saxon9ee.jar -xsl:./lib/extract-xml-schema-documentation.xsl -export:./lib/extract-xml-schema-documentation.sef -nogo
