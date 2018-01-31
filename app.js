//var SaxonJS = require("./lib/Saxon-JS-1.0.0/SaxonJS.js");
console.log("\nSaxonJS 1.0.0 does not support NodeJS, planned for future release.  This implements bash script Saxon java execution.");
var exec = require("child_process").exec;
var fs = require("fs"), path = require("path");
var SCRIPT_FILE = "./bin/extract-content.sh"

function writeFile (xmlSchemaFile, targetDir, stdout) {

  function dirPathExists(filePath) {
    var dirName = path.dirname(filePath);
    if (fs.existsSync(dirName)) {
      return true;
    }
    dirPathExists(dirName);
    fs.mkdirSync(dirName);
    return true;

    throw ("  [ERROR] can not create dirPath: " + this.targetSchemaBaseDir + this.targetSchemaFileDestination);
  };

  //var xmlSchemaFileJsonName = xmlSchemaFile.substring(0, xmlSchemaFile.lastIndexOf('.')) + "-content.json";
  var xmlSchemaFileJsonName = xmlSchemaFile.substring(xmlSchemaFile.lastIndexOf('/') + 1) + "-content.json";
  console.log("  [INFO] write: " + targetDir + xmlSchemaFileJsonName);
  if ( dirPathExists(targetDir + xmlSchemaFileJsonName) ) {
    fs.writeFileSync(targetDir + xmlSchemaFileJsonName, stdout);
  };
}

function extractContent (xmlSchemaFile, targetDir) {
  console.log("  [INFO] start: " + xmlSchemaFile);
  //exec("bash ./bin/extract-content.sh " + xmlSchemaFile, function(error, stdout, stderr) {
    exec("bash " + SCRIPT_FILE + " " + xmlSchemaFile, {maxBuffer: 1024 * 10000}, function(error, stdout, stderr) {
      if ( error != null) 
        console.log("  [ERROR] " + error)
      else
        if ( stderr != "" ) 
          console.log("  [ERROR] " + stderr )
        else {
          writeFile(xmlSchemaFile, targetDir, stdout);
          console.log("  [INFO] completed " + xmlSchemaFile);
        }
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
      console.log("  [INFO] unable to read file, treating source file as an XML Schema file.");
    }
  }

  var sourceFileBuffer = readFile(sourceFile);
  try {
    var sourceFileList = JSON.parse(sourceFileBuffer);
    return(sourceFileList);
  } catch (error) {
    console.log(error);
    console.log("  [INFO] unable to parse as JSON, treating source file as an XML Schema file.")
  }
}

function startApp (argv) {
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
}
 
function help() {
  console.log("\n  usage: " + process.argv[0] + ' ' + process.argv[1] + " source-file target-dir");
  console.log("\n  example: node app.js source\/file.xsd target\/dir\/\n");
}

function hasValidArgs(argv) {

  if (argv.length == 2) {
    //argv.forEach( function (argvItem) {
    fs.access(argv[0], function (err) {
      if (err) {
        console.log(err);
        return(false);
      }
    })
    //})
    fs.access(SCRIPT_FILE, function (err) {
      if (err) {
        console.log(err);
        console.log("  \n[ERROR] unable to access SCRIPT_FILE: " + SCRIPT_FILE);
        return(false);
      }
    })
    

  } else {
    console.log("  \n[ERROR] missing argument");
    return(false);
  };
  return(true);
}

var argv = process.argv.slice(2);
if (hasValidArgs(argv))
  startApp(argv)
else {
  help();
  process.exit(-1);
};
