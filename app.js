//var SaxonJS = require("./lib/Saxon-JS-1.0.0/SaxonJS.js");
console.log("SaxonJS 1.0.0 does not support NodeJS, planned for future release, executing bash script.");
var exec = require("child_process").exec;
var fs = require("fs"), path = require("path");
var OUTPUT_DIR = "./output/";

var fileBuffer = fs.readFileSync("./lib/xml-schema-file-list.json");
var xmlSchemaFileList = JSON.parse(fileBuffer);

function writeFile (fileListItem, stdout) {

  function dirPathExists(filePath) {
    var dirName = path.dirname(filePath);
    if (fs.existsSync(dirName)) {
      return true;
    }
    dirPathExists(dirName);
    fs.mkdirSync(dirName);
    return true;

    throw ("ERROR: Can not create dirPath: " + this.targetSchemaBaseDir + this.targetSchemaFileDestination);
  };

  var fileListItemJsonName = fileListItem.substring(0, fileListItem.lastIndexOf('.')) + "-documentation.json";
  console.log("  [INFO] write: " + OUTPUT_DIR + fileListItemJsonName);
  if ( dirPathExists(OUTPUT_DIR + fileListItemJsonName) ) {
    fs.writeFileSync(OUTPUT_DIR + fileListItemJsonName, stdout);
  };
}


xmlSchemaFileList.schemaSourceFileList.forEach(function(item) {
  console.log("  [INFO] start: " + item);
  exec("bash ./bin/extract-content.sh " + item, function(error, stdout, stderr) {
    if ( error != null) console.log("  ERROR: " + error);
    if ( stderr != "" ) console.log("  STANDARD OUTPUT ERROR: " + stderr );
    writeFile(item, stdout);
    console.log("  [INFO] complete: " + item);
  });
}, this);
  
