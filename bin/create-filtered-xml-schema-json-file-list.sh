#!/usr/bin/bash
# 
# run from project root folder
#

mapping_path_constant="./input/"
mapping_path_arg=${1}
if [ -n "${mapping_path_arg}" ];
then
  mapping_path=${mapping_path_arg};
else
  mapping_path=${mapping_path_constant};
fi
BASE_PWD=$(pwd)
cd ${mapping_path}
SOURCE_PWD=$(pwd)
#EXTENSION_DIR=$(find ${mapping_path}/extension -name "*.xsd" | tr "\n" " " | sed 's/ /", "/g')
#EXTENSION_DIR=$(find extension -name "*.xsd" | sed 's/\.\.\///g' | tr "\n" " " | sed 's/ /", "/g')
#EXTENSION_DIR=$(find extension -name "*.xsd" | sed 's#^#'"${SOURCE_PWD}"'\/#' | tr "\n" " " | sed 's/ /", "/g')
EXTENSION_DIR=$(find extension -name "*.xsd" | tr "\n" " " | sed 's/ /", "/g')
NIEM_CODES_DIR=$(find niem/codes -name "*.xsd" | tr "\n" " " | sed 's/ /", "/g')
NIEM_DOMAINS_DIR=$(find niem/domains -name "*.xsd" | tr "\n" " " | sed 's/ /", "/g')
NIEM_NIEM_CORE_DIR=$(find niem/niem-core -name "*.xsd" | tr "\n" " " | sed 's/ /", "/g')
NIEM_STRUCTURES_DIR=$(find niem/structures -name "*.xsd" | tr "\n" " " | sed 's/ /", "/g')
FILE_LIST='"'${EXTENSION_DIR}${NIEM_CODES_DIR}${NIEM_DOMAINS_DIR}${NIEM_NIEM_CORE_DIR}${NIEM_STRUCTURES_DIR}${NIEM_STRUCTURES_DIR:0:${#NNIEM_STRUCTURES_DIR}-3}
XML_SCHEMA_FILE_LIST_JSON='{"schemaSourceFileList": ['${FILE_LIST}']}'
cd ${BASE_PWD}
echo ${XML_SCHEMA_FILE_LIST_JSON} | tee ./lib/xml-schema-file-list.json

