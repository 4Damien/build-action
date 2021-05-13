//%attributes = {}
ON ERR CALL:C155("onError")  // ignore all, do not want to block CI

var $r : Real
var $startupParam : Text
$r:=Get database parameter:C643(User param value:K37:94; $startupParam)

If (Length:C16($startupParam)>0)
	
	LOG EVENT:C667(Into system standard outputs:K38:9; "...parsing parameters\n")
	
	var $config : Object
	$config:=JSON Parse:C1218($startupParam)
	$config.file:=File:C1566($config.path)
	$config.workingDirectory:=Folder:C1567($config.workingDirectory).path  // ensure trailing /
	
	If ($config.components=Null:C1517)
		var $databaseFolder : 4D:C1709.Folder
		$databaseFolder:=$config.file.parent.parent
		If ($databaseFolder.folder("Components").exists)
			LOG EVENT:C667(Into system standard outputs:K38:9; "...adding dependencies\n")
			$config.components:=New collection:C1472
			var $dependency : 4D:C1709.Folder
			For each ($dependency; $databaseFolder.folder("Components").folders())
				If ($dependency.file($dependency.name+".4DZ").exists)
					$config.components.push($dependency.file($dependency.name+".4DZ"))
				End if 
			End for each 
		End if 
	End if 
	
	LOG EVENT:C667(Into system standard outputs:K38:9; "...launching compilation\n")
	var $status : Object
	$status:=Compile project:C1760($config.file; $config.options)
	
	If ($status.success)
		LOG EVENT:C667(Into system standard outputs:K38:9; "✅ Build success\n")
	Else 
		LOG EVENT:C667(Into system standard outputs:K38:9; "‼️ Build failure\n")  // Into system standard error ??
		If ($status.errors#Null:C1517)
			var $error : Object
			For each ($error; $status.errors)
				cs:C1710.compilationError.new($error).printGithub($config)
			End for each 
		End if 
	End if 
End if 

If (Not:C34(Shift down:C543))
	QUIT 4D:C291()
End if 
