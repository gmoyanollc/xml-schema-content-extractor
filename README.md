# XML Schema Content Extractor
xml-schema-content-extractor takes data component documentation and facets from XML Schema and represents it in a JSON data format.  The JSON data may used to reference a data component's documentation and facets for JSON schema development.

## Get Started
xml-schema-content-extractor may be run either as a bash script or NodeJS script.

  * Run bash script for usage: `./bin/extract-content.sh`.

     JSON data is sent to standard output and may be directed to a file for stand-alone runs.

  or

  * Run NodeJS script for usage: `node app.js`.

    JSON data is sent to the folder provided by an argument.
      
## Optional Batch Configuration
The bash script `./bin/create-xml-schema-file-list.sh` creates a JSON listing of input XML Schema files. 

  * Run bash script for usage: `./bin/create-xml-schema-file-list.sh`

A JSON listing is created in a file named `xml-schema-file-list.json`. 

## Compile XSLT Change
XSLT changes may be compiled.  Compile stylesheet changes by running the provided `compile-xslt` bash script.  

# Authoritative Sources

The authoritative and complete work is maintained on [GitHub](https://github.com/gmoyanollc/xml-schema-content-extractor).

[George Moyano](https://onename.com/gmoyano)
@github/gmoyanollc
modified: Jun 28 2018
