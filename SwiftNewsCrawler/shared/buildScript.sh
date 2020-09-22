#!/bin/bash -e
IFS=$'\n'
sourceIconName=""$TARGET_NAME"/RawImages/appIcon.png"

# Check imagemagick is installed
# http://stackoverflow.com/questions/592620/check-if-a-program-exists-from-a-bash-script
command -v convert >/dev/null 2>&1 || { echo >&2 "I require imagemagick but it's not installed.  Aborting."; exit 1; }

launchScreenBackground="./"$TARGET_NAME"/Assets.xcassets/background.imageset"
launchScreenCenter="./"$TARGET_NAME"/Assets.xcassets/center.imageset"

mkdir -p "$launchScreenBackground"
mkdir -p "$launchScreenCenter"

# clean it out
rm -rf $launchScreenBackground/*.png
rm -rf $launchScreenCenter/*.png


# read statusBarColor from info.plist
COLOR=$(/usr/libexec/PlistBuddy -c "Print statusBarColor" "${PROJECT_DIR}/${INFOPLIST_FILE}")
#echo $COLOR
convert -size 1242x2208 xc:$COLOR $launchScreenBackground/background@3x.png
convert -size 640x1136 xc:$COLOR $launchScreenBackground/background@2x.png
convert -size 320x480 xc:$COLOR $launchScreenBackground/background.png

function generateContentJson() {
    destination=$1
    iconName=$2
    cat > "$destination/Contents.json" << EOF
    {
      "images" : [
        {
          "filename" : "$iconName.png",
          "idiom" : "universal",
          "scale" : "1x"
        },
        {
          "filename" : "$iconName@2x.png",
          "idiom" : "universal",
          "scale" : "2x"
        },
        {
          "filename" : "$iconName@3x.png",
          "idiom" : "universal",
          "scale" : "3x"
        }
      ],
      "info" : {
        "author" : "xcode",
        "version" : 1
      }
    }
EOF
}
generateContentJson $launchScreenBackground "background"

#LaunchScreenCenter imageset generation

function generateImageSet () {
    sourceIconName=$1
    destination=$2
    iconName=$3
    echo "$sourceIconName" 1>&2
    WIDTH=$(identify -format %w ${sourceIconName})
    WidthXX=$(echo "${WIDTH} * 0.67" | bc -l)
    WidthX=$(echo "${WIDTH} * 0.33" | bc -l)
    convert $sourceIconName -resize ${WidthX}x${WidthX} $destination/$iconName.png
    convert $sourceIconName -resize $WidthXXx$WidthXX $destination/$iconName@2x.png
    convert $sourceIconName -resize $WIDTHx$WIDTH $destination/$iconName@3x.png
}

generateImageSet $sourceIconName $launchScreenCenter "center"
generateContentJson $launchScreenCenter "center"
