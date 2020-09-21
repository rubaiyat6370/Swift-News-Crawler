#!/bin/bash -e

# --------------------------------------------------------
# Generate app icons and xcassets file from a single image
# Ben Clayton, Calvium Ltd.
#  https://gist.github.com/benvium/2be6d673aa9ac284bb8a
# --------------------------------------------------------
#
# Usage with an input of 1024x1024 PNG file
#   generateAppIcon.sh AppIcon.png
#
# Updated in October 2017 for RobLabs.com
# https://gist.github.com/roblabs/527458cbe46b0483cd2d594c7b9e583f
# Based on Xcode Version 9.0 (9A235)
# requires imagemagick
  # `brew install imagemagick`

sourceIconName=""$TARGET_NAME"/RawImages/appIcon.png"

# Check imagemagick is installed
# http://stackoverflow.com/questions/592620/check-if-a-program-exists-from-a-bash-script
command -v convert >/dev/null 2>&1 || { echo >&2 "I require imagemagick but it's not installed.  Aborting."; exit 1; }

iconPath="./"$TARGET_NAME"/Assets.xcassets/AppIcon.appiconset"

echo "$iconPath" 1>&2

launchScreenBackground="./"$TARGET_NAME"/Assets.xcassets/background.imageset"
launchScreenCenter="./"$TARGET_NAME"/Assets.xcassets/center.imageset"

mkdir -p "$iconPath"
mkdir -p "$launchScreenBackground"
mkdir -p "$launchScreenCenter"

# clean it out
rm -rf $iconPath/*.png
rm -rf $launchScreenBackground/*.png
rm -rf $launchScreenCenter/*.png

# read statusBarColor from info.plist
COLOR=$(/usr/libexec/PlistBuddy -c "Print statusBarColor" "${PROJECT_DIR}/${INFOPLIST_FILE}")
#echo $COLOR
convert -size 1242x2208 xc:$COLOR $launchScreenBackground/background@3x.png
convert -size 640x1136 xc:$COLOR $launchScreenBackground/background@2x.png
convert -size 320x480 xc:$COLOR $launchScreenBackground/background.png

cat > "$launchScreenBackground/Contents.json" << EOF
{
  "images" : [
    {
      "filename" : "background.png",
      "idiom" : "universal",
      "scale" : "1x"
    },
    {
      "filename" : "background@2x.png",
      "idiom" : "universal",
      "scale" : "2x"
    },
    {
      "filename" : "background@3x.png",
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

#LaunchScreenCenter imageset generation

convert $sourceIconName -resize 341x341 $launchScreenCenter/center.png
convert $sourceIconName -resize 682x682 $launchScreenCenter/center@2x.png
convert $sourceIconName -resize 1024x1024 $launchScreenCenter/center@3x.png

cat > "$launchScreenCenter/Contents.json" << EOF
{
  "images" : [
    {
      "filename" : "center.png",
      "idiom" : "universal",
      "scale" : "1x"
    },
    {
      "filename" : "center@2x.png",
      "idiom" : "universal",
      "scale" : "2x"
    },
    {
      "filename" : "center@3x.png",
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

#App Icon Generation
# iPhone Notification
convert $sourceIconName -resize 40x40 $iconPath/iPhone-Notification-20pt@2x.png
convert $sourceIconName -resize 60x60 $iconPath/iPhone-Notification-20pt@3x.png

# iPhone Spotlight Settings
convert $sourceIconName -resize 29x29 $iconPath/iPhone-Spotlight-Settings-29pt.png
convert $sourceIconName -resize 58x58 $iconPath/iPhone-Spotlight-Settings-29pt@2x.png
convert $sourceIconName -resize 87x87 $iconPath/iPhone-Spotlight-Settings-29pt@3x.png

# iPhone Spotlight
convert $sourceIconName -resize 80x80 $iconPath/iPhone-Spotlight-40pt@2x.png
convert $sourceIconName -resize 120x120 $iconPath/iPhone-Spotlight-40pt@3x.png

# iPhone App
convert $sourceIconName -resize 120x120 $iconPath/iPhone-App-60pt@2x.png
convert $sourceIconName -resize 180x180 $iconPath/iPhone-App-60pt@3x.png

# iPad Notifications
convert $sourceIconName -resize 20x20 $iconPath/iPad-Notifications-20pt.png
convert $sourceIconName -resize 40x40 $iconPath/iPad-Notifications-20pt@2x.png

# iPad Settings
convert $sourceIconName -resize 29x29 $iconPath/iPad-Settings-29pt.png
convert $sourceIconName -resize 58x58 $iconPath/iPad-Settings-29pt@2x.png

# iPad Spotlight
convert $sourceIconName -resize 40x40 $iconPath/iPad-Spotlight-40pt.png
convert $sourceIconName -resize 80x80 $iconPath/iPad-Spotlight-40pt@2x.png

# iPad App
convert $sourceIconName -resize 76x76 $iconPath/iPad-App-76pt.png
convert $sourceIconName -resize 152x152 $iconPath/iPad-App-76pt@2x.png

# iPad Pro App
convert $sourceIconName -resize 167x167 $iconPath/iPad-Pro-App-83.5pt@2x.png

# iOS Marketing
convert $sourceIconName -resize 1024x1024 $iconPath/ios-marketing-512pt@2x.png



cat > "$iconPath/Contents.json" << EOF
{
  "images": [
    {
      "size": "20x20",
      "idiom": "iphone",
      "filename": "iPhone-Notification-20pt@2x.png",
      "scale": "2x"
    },
    {
      "size": "20x20",
      "idiom": "iphone",
      "filename": "iPhone-Notification-20pt@3x.png",
      "scale": "3x"
    },
    {
      "size": "29x29",
      "idiom": "iphone",
      "filename": "iPhone-Spotlight-Settings-29pt.png",
      "scale": "1x"
    },
    {
      "size": "29x29",
      "idiom": "iphone",
      "filename": "iPhone-Spotlight-Settings-29pt@2x.png",
      "scale": "2x"
    },
    {
      "size": "29x29",
      "idiom": "iphone",
      "filename": "iPhone-Spotlight-Settings-29pt@3x.png",
      "scale": "3x"
    },
    {
      "size": "40x40",
      "idiom": "iphone",
      "filename": "iPhone-Spotlight-40pt@2x.png",
      "scale": "2x"
    },
    {
      "size": "40x40",
      "idiom": "iphone",
      "filename": "iPhone-Spotlight-40pt@3x.png",
      "scale": "3x"
    },
    {
      "size": "60x60",
      "idiom": "iphone",
      "filename": "iPhone-App-60pt@2x.png",
      "scale": "2x"
    },
    {
      "size": "60x60",
      "idiom": "iphone",
      "filename": "iPhone-App-60pt@3x.png",
      "scale": "3x"
    },
    {
      "size": "20x20",
      "idiom": "ipad",
      "filename": "iPad-Notifications-20pt.png",
      "scale": "1x"
    },
    {
      "size": "20x20",
      "idiom": "ipad",
      "filename": "iPad-Notifications-20pt@2x.png",
      "scale": "2x"
    },
    {
      "size": "29x29",
      "idiom": "ipad",
      "filename": "iPad-Settings-29pt.png",
      "scale": "1x"
    },
    {
      "size": "29x29",
      "idiom": "ipad",
      "filename": "iPad-Settings-29pt@2x.png",
      "scale": "2x"
    },
    {
      "size": "40x40",
      "idiom": "ipad",
      "filename": "iPad-Spotlight-40pt.png",
      "scale": "1x"
    },
    {
      "size": "40x40",
      "idiom": "ipad",
      "filename": "iPad-Spotlight-40pt@2x.png",
      "scale": "2x"
    },
    {
      "size": "76x76",
      "idiom": "ipad",
      "filename": "iPad-App-76pt.png",
      "scale": "1x"
    },
    {
      "size": "76x76",
      "idiom": "ipad",
      "filename": "iPad-App-76pt@2x.png",
      "scale": "2x"
    },
    {
      "size": "83.5x83.5",
      "idiom": "ipad",
      "filename": "iPad-Pro-App-83.5pt@2x.png",
      "scale": "2x"
    },
    {
      "size": "1024x1024",
      "idiom": "ios-marketing",
      "filename": "ios-marketing-512pt@2x.png",
      "scale": "1x"
    }
  ],
  "info": {
    "version": 1,
    "author": "xcode"
  },
  "properties": {
    "pre-rendered": true
  }
}
EOF

