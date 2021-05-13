//%attributes = {}
var $name : Text
var $status : Object
var $options : Object
var $prj : 4D:C1709.File

$name:="ok"
$prj:=Folder:C1567(Folder:C1567(fk resources folder:K87:11).platformPath; fk platform path:K87:2).folder("test").folder($name).folder("Project").file($name+".4DProject")
$options:=New object:C1471()
$status:=Compile project:C1760($prj; $options)
ASSERT:C1129($status.success; "must success")

$name:="ko"
$prj:=Folder:C1567(Folder:C1567(fk resources folder:K87:11).platformPath; fk platform path:K87:2).folder("test").folder($name).folder("Project").file($name+".4DProject")
$options:=New object:C1471()
$status:=Compile project:C1760($prj; $options)
ASSERT:C1129(Not:C34($status.success); "must failed")


