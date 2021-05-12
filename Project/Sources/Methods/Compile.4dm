//%attributes = {}


var $r : Real
var $startupParam : Text
$r:=Get database parameter:C643(User param value:K37:94; $startupParam)

If (Length:C16($startupParam)>0)
	
	LOG EVENT:C667(6; "Parsing parameters")
	var $config : Object
	$config:=JSON Parse:C1218($startupParam)
	
	LOG EVENT:C667(6; "Launching compilation")
	var $status : Object
	$status:=Compile project:C1760(File:C1566($config.path); $config.options)
	
	If ($status.errors#Null:C1517)
		// output all
		LOG EVENT:C667(6; JSON Stringify:C1217($status))
		
		// or we could output in std out or std err by line
/*For each ($error; $status.errors)
LOG EVENT(6; JSON Stringify($error))  // here we could also format a message like String($err.line)+":"+$err.name+":'+$err.message
End for each */
	Else 
		//LOG EVENT(6; "All is ok")
	End if 
	
	// else assert? or quit with exit code 
End if 

//LOG EVENT(6; "Will quit")
If (Not:C34(Shift down:C543))  // allow to open database, but let cli app stop when finish
	//LOG EVENT(6; "Launch quit")
	QUIT 4D:C291()
End if 
