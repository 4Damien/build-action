//%attributes = {}
var $r : Real
var $startupParam : Text
$r:=Get database parameter:C643(User param value:K37:94; $startupParam)

If (Length:C16($startupParam)>0)
	
	LOG EVENT:C667(6; "...Parsing parameters\n")
	var $config : Object
	$config:=JSON Parse:C1218($startupParam)
	$config.path:=File:C1566($config.path)
	
	LOG EVENT:C667(6; "...Launching compilation\n")
	var $status : Object
	$status:=Compile project:C1760($config.path; $config.options)
	
	If ($status.success)
		LOG EVENT:C667(6; "✅ Build success")
	Else 
		LOG EVENT:C667(6; "‼️ Build failure")
		If ($status.errors#Null:C1517)
			For each ($error; $status.errors)
				cs:C1710.error.new($error).printGithub($config)
			End for each 
		End if 
	End if 
End if 

If (Not:C34(Shift down:C543))
	QUIT 4D:C291()
End if 
