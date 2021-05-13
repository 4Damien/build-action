
// $error content :
//   message: Text
//   isError: Bool
//   code: Object
//   - type: String
//   - database: String
//   - methodName: String
//   - path: String
//   - file: 4D.File
//   - line: Integer
//   - lineInFile: Integer
Class constructor($error : Object)
	// copy
	var $key : Text
	For each ($key; $error)
		This:C1470[$key]:=$error[$key]
	End for each 
	
Function printGithub($config : Object)
	var $cmd : Text
	$cmd:=Choose:C955(This:C1470.isError; "error"; "warning")
	
	var $file : Text
	$file:=Replace string:C233(File:C1566(This:C1470.code.file.platformPath; fk platform path:K87:2).path; $config.workingDirectory; "")
	
	LOG EVENT:C667(Into system standard outputs:K38:9; "::"+$cmd+" file="+$file+",line="+String:C10(This:C1470.code.lineInFile)+"::"+String:C10(This:C1470.message)+"\n")
	