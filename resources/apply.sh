#!/bin/sh

IFS=',' read -ra r <<< "$RESOURCES"

api="api."

for i in "${r[@]}"
do
  if [[ $i == $api* ]];
  then
    resource=${i#$api};
    bash "$PWD/resources/$resource.sh"
  fi
done
