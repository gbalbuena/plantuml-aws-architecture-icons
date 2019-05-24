#!/bin/bash

find $(pwd) -type d -print0 | 
  while IFS= read -r -d '' d; do 
    find $d -depth -name '*-*.png' \
      -execdir bash -c 'mv -- "$1" "${1//-/_}"' bash {} \;
  done

find $(pwd) -type f -name '*.png' -print0 | 
  while IFS= read -r -d '' i; do 
    java -jar plantuml.1.2019.5.jar -encodesprite 16z $i > "${i%.*}.puml"
  done

total_png=$(find $(pwd) -type f -name '*.png' | wc -l)
total_puml=$(find $(pwd) -type f -name '*.puml' | wc -l)

echo $total_png
echo $total_puml