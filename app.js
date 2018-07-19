//var SaxonJS = require("./lib/Saxon-JS-1.0.0/SaxonJS.js");
console.log("\nSaxonJS 1.0.0 does not support NodeJS, planned for future release.  This implements bash script Saxon java execution.");
const { spawn } = require("child_process");
var fs = require("fs"), path = require("path");
var SCRIPT_FILE = "./bin/extract-content.sh"
var XSL_FILE = "./lib/extract-xml-schema-content.xsl"

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

  var xmlSchemaFileJsonName = xmlSchemaFile.substring(xmlSchemaFile.lastIndexOf('/') + 1) + "-content.json";
  console.log("  [INFO] write: " + targetDir + '/' + xmlSchemaFileJsonName);
  if ( dirPathExists(targetDir + '/' + xmlSchemaFileJsonName) ) {
    fs.writeFileSync(targetDir + '/' + xmlSchemaFileJsonName, stdout);
  };
}

function validateJson (jsonString, xmlSchemaFile) {
  try {
    var jsonObject = JSON.parse(jsonString);
    var prettyJson = JSON.stringify(jsonObject, null, "  ")
    console.log("  [INFO] extraction JSON format is valid for: " + xmlSchemaFile);
  } catch (error) {
    console.log("  [ERROR] extraction JSON format is invalid for: " + xmlSchemaFile);
    console.log("    " + error.message);
  }
  return(prettyJson);
}

function extractContent (xmlSchemaFile, targetDir, saxonJarFile) {
  let content = ""
  console.log("  [INFO] start: " + xmlSchemaFile);
  const child = spawn("bash", [ SCRIPT_FILE, xmlSchemaFile, saxonJarFile, XSL_FILE ], { shell: true } );

  child.on("exit", function (exitCode, exitSignal) {
    if ( exitSignal != null) {
      console.log("  [ERROR] failed to extract: " + xmlSchemaFile);
      console.log("      `-- exitSignal: " + exitSignal)
    } else {
      if ( exitCode != "" ) {
        console.log("  [ERROR] failed to extract: " + xmlSchemaFile);
        console.log("      `-- exitCode: " + exitCode );
      }
    }
  });

  child.stdout.on("data", function(stdoutChunk) {
    content += stdoutChunk
  })

  child.stdout.on("end", function() {
    var prettyJson = validateJson(content, xmlSchemaFile);
    if ( typeof prettyJson != "undefined" ) {
      writeFile(xmlSchemaFile, targetDir, prettyJson);
      console.log("  [INFO] completed: " + xmlSchemaFile)
    } else {
      console.log("  [WARNING] failed to extract: " + xmlSchemaFile);
      writeFile(xmlSchemaFile, targetDir, content);
    }
  });

  child.stderr.on('data', function(stderr){
    console.log("  [ERROR] failed to extract: " + xmlSchemaFile);
    console.log("      `-- stderr: " + stderr)
  });
  
  child.on("error", function (err) {
    console.log("  [ERROR] failed to run extraction for: " + SCRIPT_FILE)
  })
}

function getSourceFileList (sourceFile) {
  function readFile(sourceFile) {
    try {
      console.log("  read file: " + sourceFile);
      var sourceFileBuffer = fs.readFileSync(sourceFile);
      return (sourceFileBuffer);
    } catch (error) {
      console.log("  [WARNING] " + error.message);
      console.log("  [INFO] unable to read file, will ignore and try source file as an XML Schema file.");
    }
  }

  var sourceFileBuffer = readFile(sourceFile);
  try {
    var sourceFileList = JSON.parse(sourceFileBuffer);
    return(sourceFileList);
  } catch (error) {
    console.log("  [WARNING] " + error.message);
    console.log("  [INFO] unable to parse as JSON, will ignore and try source file as an XML Schema file.")
  }
}

//function startApp (argv) {
function startApp (sourceFile, targetDir, saxonJarFile) {
  //let sourceFile = argv[0]
  //let targetDirArg = argv[1]
  // targetDirParsed = targetDir.substring(0, targetDir.length - 1)
  var sourceFileList = getSourceFileList(sourceFile);
  if (typeof sourceFileList != "undefined") {
    if (typeof sourceFileList.schemaSourceFileList != "undefined")
      // targetDirParsed = targetDir.substring(0, targetDir.length - 1)
      var targetFolderName = targetDir.substring(0, targetDir.lastIndexOf('/') + 1);
      var schemaSourceFileListItemPathSplit;
      var targetDirSuffix = "";

      sourceFileList.schemaSourceFileList.forEach(function(schemaSourceFileListItem) {
        schemaSourceFileListItemPathSplit = schemaSourceFileListItem.split(targetFolderName);
        //if (schemaSourceFileListItemPathSplit.length == 2) {
        if (schemaSourceFileListItemPathSplit.length == 2)
          targetDirSuffix = schemaSourceFileListItemPathSplit[1].substring(0, schemaSourceFileListItemPathSplit[1].lastIndexOf('/'));          
        extractContent(schemaSourceFileListItem, targetDir + targetDirSuffix, saxonJarFile)
        //} else
        //  console.log("  [ERROR] unable to parse target suffix path for schemaSourceFileListItem: " + schemaSourceFileListItem);
      }, this)

  } else
    extractContent(sourceFile, targetDir, saxonJarFile)
}
 
function help() {
  console.log("\n  usage:", process.argv[0], process.argv[1], "source-file target-dir saxon-jar-file");
  console.log("\n  example: node app.js source\/file.xsd target\/dir /opt/saxonica/Saxon9he.jar\n");
}

function hasValidArgs(argv) {

  if (argv.length == 3) {
    sourceFile = argv[0]
    saxonJarFile = argv[1]
    targetDir = argv[2]
    fs.existsSync(sourceFile, function (err) {
      if (err) {
        console.log(err);
        console.log("\n  [ERROR] unable to access source file:", sourceFile);
        return(false);
      }
    })
    fs.existsSync(saxonJarFile, function (err) {
      if (err) {
        console.log(err);
        console.log("\n  [ERROR] unable to access Saxon jar file:", saxonJarFile);
        return(false);
      }
    })
    fs.existsSync(SCRIPT_FILE, function (err) {
      if (err) {
        console.log(err)
        console.log("\n  [ERROR] unable to access script file:", SCRIPT_FILE)
        console.log("\n    try again from:", path.basename(__dirname))
        return(false)
      }
    })
    fs.existsSync(XSL_FILE, function (err) {
      if (err) {
        console.log(err)
        console.log("\n  [ERROR] unable to access XSL file:", XSL_FILE)
        console.log("\n    try again from:", path.basename(__dirname))
        return(false)
      }
    })
  } else {
    console.log("\n  [ERROR] missing argument");
    return(false);
  };
  return(true);
}

var argv = process.argv.slice(2);
if (hasValidArgs(argv)) {
  var sourceFile = argv[0]
  var targetDir
  if (argv[1].slice(-1) != '/') 
    targetDir = argv[1] + '/'
  else
    targetDir = argv[1]
  var saxonJarFile = argv[2]
  //startApp(argv)
  startApp(sourceFile, targetDir, saxonJarFile)
} else {
  help();
  process.exit(-1);
};
