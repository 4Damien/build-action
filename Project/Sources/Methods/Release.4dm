//%attributes = {}
#DECLARE($config : Object)->$status : Object

var $databaseFolder : 4D:C1709.Folder
$databaseFolder:=$config.file.parent.parent
print("...will archive "+$databaseFolder.name)

// archive and move it
var $destination : 4D:C1709.File
$destination:=Folder:C1567(Temporary folder:C486; fk platform path:K87:2).folder(Generate UUID:C1066)
$destination.create()
SHOW ON DISK:C922($destination.platformPath)


print("...4dz creation")
// copy all base to destination
$destination:=$databaseFolder.copyTo($destination; $databaseFolder.name+".4dbase"; fk overwrite:K87:5)
// remove all sources (could be opt if want to distribute with sources, add an option?)
$destination.folder("Project").files(fk recursive:K87:7).query("extension=.4dm")
// zip into 4dz compilation files
$status:=ZIP Create archive:C1640($destination.folder("Project"); $destination.file($databaseFolder.name+".4DZ"))
// finally clean all
$destination.folder("Project").delete(Delete with contents:K24:24)
// XXX could clean also logs, pref etc.. but must not be in vcs...
If (Not:C34($status.success))
	print("error when creating 4z:"+String:C10($status.statusText))
End if 

If ($status.success)
	// the 4d base
	print("...final archive creation")
	$destination:=$destination.parent
	var $artefact : 4D:C1709.File
	$artefact:=$destination.file($databaseFolder.name+".zip")
	$status:=ZIP Create archive:C1640($destination.folder($databaseFolder.name+".4dbase"); $destination.file($databaseFolder.name+".zip"))
	If (Not:C34($status.success))
		print("error when creating archive:"+String:C10($status.statusText))
	End if 
End if 

If ($status.success)
	// Send to release
	print("...send archive to release")
	var $github : Object
	$github:=cs:C1710.github.new()
	$status:=$github.postArtefact($artefact)
	If (Not:C34($status.success))
		print("error when pusing artifact to release:"+String:C10($status.statusText))
	End if 
	
	print("...cleaning")
	$destination.delete(Delete with contents:K24:24)
	
End if 
