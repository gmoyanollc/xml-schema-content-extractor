# XML Schema Content Extractor
xml-schema-content-extractor takes data component documentation and facets in XML Schema and represents it in a JSON data format.

## Get Started

  1. Run bash script `./bin/extract-content.sh`.

    example: 
    
      `bash ./bin/extract-content.sh ./data/xml-schema/domain-x/type.xsd | tee ./data/extraction/domain-x/type.xsd-content.json`
      
## Optional Batch Configuration
The bash script `./bin/create-filtered-xml-schema-json-file-list.sh` creates a JSON listing of input XML Schema files.  It may require modification of paths to input XML Schema and XSLT processor.  

After modifying it for your environment, execute the bash script:

  `bash ./bin/create-filtered-xml-schema-json-file-list.sh`

A JSON listing is created in file `xml-schema-file-list.json`. 

## Compile XSLT Change
XSLT changes require compilation when using the xml-schema-content-extractor bash script.  

Compile stylesheet changes by running the provided compile-xslt bash script.  

(Note: The xml-schema-content-extractor bash script applies a compiled stylesheet although it may be modified to apply an uncompiled stylesheet.)

# Authoritative Sources

The authoritative and complete work is maintained on [GitHub](https://github.com/gmoyanollc/xml-schema-content-extractor).

[George Moyano](https://onename.com/gmoyano)
@github/gmoyanollc
modified: May 10 2018