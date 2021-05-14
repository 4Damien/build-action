//%attributes = {}
ON ERR CALL:C155("onError")  // ignore all, do not want to block CI

var $r : Real
var $startupParam : Text
$r:=Get database parameter:C643(User param value:K37:94; $startupParam)
If (Length:C16($startupParam)>0)
	
	print("...parsing parameters")
	
	var $config : Object
	$config:=JSON Parse:C1218($startupParam)
	$config.file:=File:C1566($config.path)
	$config.workingDirectory:=Folder:C1567($config.workingDirectory).path  // ensure trailing /
	
	
	var $status : Object
	$status:=Compile($config)
	
	var $doRelease : Boolean
	$doRelease:=Bool:C1537(Num:C11(String:C10(cs:C1710.github.new()["RELEASE"])))  // maybe replace by a collection of action in startup param
	If ($status.success & $doRelease)
		$status:=Release($config)
	End if 
	
Else 
	
	print("error No parameters passed to database")
	
End if 

If (Not:C34(Shift down:C543))
	QUIT 4D:C291()
End if 