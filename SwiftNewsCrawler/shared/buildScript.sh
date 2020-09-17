#!/bin/bash
IFS=$'\n'
#1
PATH=${PATH}:/usr/local/bin
COLOR=$(/usr/libexec/PlistBuddy -c "Print backgroundColor" "${PROJECT_DIR}/${INFOPLIST_FILE}")
#echo $COLOR
convert -size 1024x1024 xc:$COLOR shared/color.png
