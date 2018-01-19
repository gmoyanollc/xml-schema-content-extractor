//var SaxonJS = require("./lib/Saxon-JS-1.0.0/SaxonJS.js");
console.log("\nSaxonJS 1.0.0 does not support NodeJS, planned for future release.  This implements bash script Saxon java execution.");
var exec = require("child_process").exec;
var fs = require("fs"), path = require("path");
var SCRIPT_FILE = "./bin/extract-content.sh"
//var OUTPUT_DIR = "./output/";

//var fileBuffer = fs.readFileSync("./lib/xml-schema-file-list.json");
//var xmlSchemaFileList = JSON.parse(fileBuffer);

function writeFile (xmlSchemaFile, targetDir, stdout) {

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

  var xmlSchemaFileJsonName = xmlSchemaFile.substring(0, xmlSchemaFile.lastIndexOf('.')) + "-documentation.json";
  console.log("  [INFO] write: " + targetDir + xmlSchemaFileJsonName);
  if ( dirPathExists(targetDir + xmlSchemaFileJsonName) ) {
    fs.writeFileSync(targetDir + xmlSchemaFileJsonName, stdout);
  };
}

function extractContent (xmlSchemaFile, targetDir) {
  console.log("  [INFO] start: " + xmlSchemaFile);
  //exec("bash ./bin/extract-content.sh " + xmlSchemaFile, function(error, stdout, stderr) {
    exec("bash " + SCRIPT_FILE + " " + xmlSchemaFile, function(error, stdout, stderr) {
      if ( error != null) console.log("  ERROR: " + error);
      if ( stderr != "" ) console.log("  STANDARD OUTPUT ERROR: " + stderr );
      writeFile(xmlSchemaFile, targetDir, stdout);
      console.log("  [INFO] complete: " + xmlSchemaFile);
    });
}

function getSourceFileList (sourceFile) {
  function readFile(sourceFile) {
    try {
      console.log("  read file: " + sourceFile);
      var sourceFileBuffer = fs.readFileSync(sourceFile);
      return (sourceFileBuffer);
    } catch (error) {
      console.log(error);
      console.log("  Unable to read file, treating source file as an XML Schema file.");
    }
  }

  var sourceFileBuffer = readFile(sourceFile);
  try {
    var sourceFileList = JSON.parse(sourceFileBuffer);
    return(sourceFileList);
  } catch (error) {
    console.log(error);
    console.log("  Unable to parse as JSON, treating source file as an XML Schema file.")
  }
}

function startApp () {
  var sourceFile = argv[0];
  var targetDir = argv[1];
  var sourceFileList = getSourceFileList(sourceFile);
  if (typeof sourceFileList != "undefined") {
    if (typeof sourceFileList.schemaSourceFileList != "undefined") 

      sourceFileList.schemaSourceFileList.forEach(function(schemaSourceFileListItem) {
        extractContent(schemaSourceFileListItem, targetDir);
      }, this)

  } else
    extractContent(sourceFile, targetDir);
  console.log("  done.")
}
 
function help() {
  console.log("\n  usage: " + process.argv[0] + ' ' + process.argv[1] + " source-file target-dir");
  console.log("\n  example: node app.js source\\file.xsd target\\dir\\\n");
}

var argv = process.argv.slice(2);
if (argv.length == 2) {
  
  //argv.forEach( function (argvItem) {
    fs.access(argv[0], function (err) {
      if (err) {
        console.log(err);
        help();
      }
    })
  //})

  fs.access(SCRIPT_FILE, function (err) {
    if (err) {
      console.log(err);
      console.log("  ERROR: unable to access SCRIPT_FILE: " + SCRIPT_FILE);
    }
    else
      startApp();
  })

} else
  help();
