//%attributes = {}

ARRAY INTEGER:C220($codesArray; 0)
ARRAY TEXT:C222($intCompArray; 0)
ARRAY TEXT:C222($textArray; 0)
GET LAST ERROR STACK:C1015($codesArray; $intCompArray; $textArray)

var $i : Integer
For ($i; 1; Size of array:C274($textArray); 1)
	LOG EVENT:C667(Into system standard outputs:K38:9; "::error ::"+$textArray{$i})
End for 