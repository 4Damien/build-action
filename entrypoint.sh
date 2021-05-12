#!/bin/bash

# parameters
projectFile=$1

if [ -z "$projectFile" ]; then
    projectFile=`find $(pwd) -name "*.4DProject" -not -path "./Components/*" | head -n 1`
    projectFile="$projectFile"
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
options="--dataless"

tmp_dir=$(mktemp -d -t ci-XXXXXXXXXX)
output="$tmp_dir/build.log" # redirect because 4D do not use stderr and return a correct status code according to build result

echo "⚙️ Launching compilation"

# echo "▪️ $compiler $options -p $builder --user-param {\"path\":\"$projectFile\",\"options\":{}}"
$compiler $options -p "$builder" --user-param "{\"path\":\"$projectFile\",\"options\":{}}" > $output 2>&1
# TODO maybe check if some parameter like do not find the project file, we have a status
echo "" >> $output # ensure a blanc final line

# manage output to exit with a correct status
statusCode=0
while IFS= read -r line
do
  if [[ $line == *"isError"* ]]; then # TODO check if error according to "status": True or any other means
    >&2 echo "$line"
    statusCode=1
  else
    echo "$line"
  fi
done < "$output"

rm -f $output

exit $statusCode
