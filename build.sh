#!/bin/bash

find "$(pwd)/AWS_Architecture_Icons_PNG" -type d -print0 | 
  while IFS= read -r -d '' d; do 
    find $d -depth -name '*-*.png' \
      -execdir bash -c 'mv -- "$1" "${1//-/_}"' bash {} \;
  done

find "$(pwd)/AWS_Architecture_Icons_PNG" -type f -name '*.png' -print0 | 
  while IFS= read -r -d '' i; do
    if [ -f "${i%.*}.puml" ]; then
      echo "$i already exist."
    else 
      java -jar plantuml.1.2019.5.jar -encodesprite 16z "$i" > "${i%.*}.puml"
    fi
  done

total_png=$(find $(pwd) -type f -name '*.png' | wc -l)
total_puml=$(find $(pwd) -type f -name '*.puml' | wc -l)

echo $total_png
echo $total_puml