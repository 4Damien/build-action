//%attributes = {}

var $app : 4D:C1709.Folder
$app:=Folder:C1567(Application file:C491; fk platform path:K87:2)

SET ENVIRONMENT VARIABLE:C812("FOUR_D_BUILD_APP_PATH"; $app.path)

var $sh : 4D:C1709.File
$sh:=Folder:C1567(Folder:C1567(fk database folder:K87:14).platformPath; fk platform path:K87:2).file("4dcompiler.sh")

var $cmd; $in; $out; $err : Text


var $name : Text
$name:="ko"

var $prj : 4D:C1709.File
$prj:=Folder:C1567(Folder:C1567(fk resources folder:K87:11).platformPath; fk platform path:K87:2).folder("test").folder($name).folder("Project").file($name+".4DProject")

$cmd:="'"+$sh.path+"' '"+$prj.path+"'"
LAUNCH EXTERNAL PROCESS:C811($cmd; $in; $out; $err)



