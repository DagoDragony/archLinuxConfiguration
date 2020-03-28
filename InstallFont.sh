#!/bin/bash

downloadUrl=https://noto-website-2.storage.googleapis.com/pkgs/Noto-unhinted.zip

###
zipFileName=${downloadUrl##*/}
outputDirectory="/usr/share/fonts/$(echo $zipFileName | sed 's/\.[^.]*$//')"
echo $zipFileName
echo "$outputDirectory"

cd ~/Downloads

curl -O $downloadUrl
mkdir -p $outputDirectory
sudo unzip $zipFileName -d $outputDirectory
fc-cache -vf