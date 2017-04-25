# Getting Started
xml-schema-content-extractor extracts documentation contained in XML Schema and represents it in a JSON format.  Typically, JSON is easier to process in programming environments than XML.

## Project Set-Up
  * Requirement: NodeJS and NodeJS Package Manager (NPM) instances.
  
  1. Place files to an empty project folder.
      
## Configuration
The bash script `./bin/create-filtered-xml-schema-json-file-list.sh` creates a JSON listing of input XML Schema files.  It may require modification of paths to input XML Schema and XSLT processor.  

After modifying it for your environment, execute the bash script:
  `bash ./bin/create-filtered-xml-schema-json-file-list.sh`

The JSON listing is created in file `xml-schema-file-list.json` in folder `./lib`. 

A sample JSON listing is provided in folder `./lib` for the sample NIEM XML Schema files.  The sample NIEM XML Schema files are contained in folder `./input`.

## Execute xml-schema-content-extractor
Now simply enter:
  `node app.js`

# Authoritative Sources

The authoritative and complete work is maintained on [GitHub](https://github.com/gmoyanollc/xml-schema-content-extractor).
