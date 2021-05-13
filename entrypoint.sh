#!/bin/bash

workingDirectory=$(pwd)

# parameters
projectFile=$1
failOnWarning=$2
options="{}"

if [ -z "$projectFile" ]; then
  projectFile=`find $workingDirectory -name "*.4DProject" -not -path "./Components/*" | head -n 1`
  projectFile="$projectFile"
fi
if [ -z "$failOnWarning" ]; then
  failOnWarning=1 # by default failed
fi

echo "👷 Build project $projectFile"

# get current dir
SOURCE="${BASH_SOURCE[0]}"
while [ -h "$SOURCE" ]; do # resolve $SOURCE until the file is no longer a symlink
  DIR="$( cd -P "$( dirname "$SOURCE" )" >/dev/null 2>&1 && pwd )"
  SOURCE="$(readlink "$SOURCE")"
  [[ $SOURCE != /* ]] && SOURCE="$DIR/$SOURCE" # if $SOURCE was a relative symlink, we need to resolve it relative to the path where the symlink file was located
done
DIR="$( cd -P "$( dirname "$SOURCE" )" >/dev/null 2>&1 && pwd )"

# launch compiler
compiler=$DIR/bin/4d-server 
builder="$DIR/Project/Compilator.4DProject"
compilerOptions="--dataless"

tmp_dir=$(mktemp -d -t ci-XXXXXXXXXX)
output="$tmp_dir/build.log" # redirect because 4D do not use stderr and return a correct status code according to build result

echo "⚙️ Launching compilation database"

# echo "▪️ $compiler $options -p $builder --user-param {\"path\":\"$projectFile\",\"options\":{}}"
$compiler $compilerOptions -p "$builder" --user-param "{\"path\":\"$projectFile\", \"workingDirectory\":\"$workingDirectory\" ,\"options\":$options}" > $output 2>&1
statusCode=$?

echo "" >> $output # ensure a blanc final line

# manage output to exit with a correct status
while IFS= read -r line
do
  if [[ $line == *"::error"* ]]; then
    >&2 echo "$line"
    statusCode=1
  elif [[ $failOnWarning -eq 1 ]] && [[ $line == *"::warning"* ]]; then
    statusCode=2
  else
    echo "$line"
  fi
done < "$output"

rm -f $output

exit $statusCode
