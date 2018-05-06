#!/usr/bin/bash
# 
# run from project root folder
#

help () { echo -e "\n  usage:  ${0} source_path target_path\n"; }

#mapping_path_constant="./input/"
#mapping_path_arg=${1}
#if [ -n "${mapping_path_arg}" ];
if [ "${#}" -eq 2 ]; then
  #mapping_path=${mapping_path_arg};
  if [ -d "${1}" ]; then
    source_path=${1}
  else
    echo -e "\n  [ERROR]  source_path not found: ${1}"
  fi
  target_path=${2}
  if [ ! -d "${2}" ]; then
    echo -e "\n  [WARNING]  target_path not found: ${2}"
    echo -e "\n  [INFO]  creating target_path: ${target_path}"
    mkdir "${target_path}"; errorCode=${?}
    if [ ! "${errorCode}" == 0 ]; then
      echo -e "\n  [ERROR][${errorCode}]  target_path not found: ${target_path}"
      exit -1
    fi
  fi
else
  echo -e "\n  [ERROR]  invalid argument count"
  help
  exit -1
fi
#BASE_PWD=$(pwd)
#cd ${mapping_path}
#SOURCE_PWD=$(pwd)
#EXTENSION_DIR=$(find ${mapping_path}/extension -name "*.xsd" | tr "\n" " " | sed 's/ /", "/g')
#EXTENSION_DIR=$(find extension -name "*.xsd" | sed 's/\.\.\///g' | tr "\n" " " | sed 's/ /", "/g')
#EXTENSION_DIR=$(find extension -name "*.xsd" | sed 's#^#'"${SOURCE_PWD}"'\/#' | tr "\n" " " | sed 's/ /", "/g')
#EXTENSION_DIR=$(find extension -name "*.xsd" | tr "\n" " " | sed 's/ /", "/g')
#NIEM_CODES_DIR=$(find niem/codes -name "*.xsd" | tr "\n" " " | sed 's/ /", "/g')
#NIEM_DOMAINS_DIR=$(find niem/domains -name "*.xsd" | tr "\n" " " | sed 's/ /", "/g')
#NIEM_NIEM_CORE_DIR=$(find niem/niem-core -name "*.xsd" | tr "\n" " " | sed 's/ /", "/g')
#NIEM_STRUCTURES_DIR=$(find niem/structures -name "*.xsd" | tr "\n" " " | sed 's/ /", "/g')
source_file_list=$(find "${source_path}" -name "*.xsd" | tr "\n" " " | sed 's/ /", "/g')
#g echo -e "\n${source_file_list}\n"
#FILE_LIST='"'${EXTENSION_DIR}${NIEM_CODES_DIR}${NIEM_DOMAINS_DIR}${NIEM_NIEM_CORE_DIR}${NIEM_STRUCTURES_DIR}${NIEM_STRUCTURES_DIR:0:${#NNIEM_STRUCTURES_DIR}-3}
file_list='"'"${source_file_list:0:-3}"
#g echo -e "\n\n${file_list}\n"
#XML_SCHEMA_FILE_LIST_JSON='{"schemaSourceFileList": ['${FILE_LIST}']}'
xml_schema_file_list_json='{"schemaSourceFileList": ['${file_list}']}'
#cd ${BASE_PWD}
#echo ${XML_SCHEMA_FILE_LIST_JSON} | tee ./lib/xml-schema-file-list.json
echo ${xml_schema_file_list_json} | tee "${target_path}/xml-schema-file-list.json"

