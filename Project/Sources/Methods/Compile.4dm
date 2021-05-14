//%attributes = {}
#DECLARE($config : Object)->$status : Object

// adding potential component from folder Components
If ($config.components=Null:C1517)
	var $databaseFolder : 4D:C1709.Folder
	$databaseFolder:=$config.file.parent.parent
	If ($databaseFolder.folder("Components").exists)
		print("...adding dependencies")
		$config.components:=New collection:C1472
		var $dependency : 4D:C1709.Folder
		For each ($dependency; $databaseFolder.folder("Components").folders())
			If ($dependency.file($dependency.name+".4DZ").exists)
				$config.components.push($dependency.file($dependency.name+".4DZ"))
			End if 
		End for each 
	End if 
End if 

print("...launching compilation")
$status:=Compile project:C1760($config.file; $config.options)

If ($status.success)
	print("✅ Build success")
Else 
	If ($status.errors#Null:C1517)
		print("::group::Compilation errors")
		var $error : Object
		For each ($error; $status.errors)
			cs:C1710.compilationError.new($error).printGithub($config)
		End for each 
		print("::endgroup::")
	End if 
	print("‼️ Build failure")  // Into system standard error ??
End if 

