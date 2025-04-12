#!/bin/bash

is_installed() {
  [ -x "$(command -v $1)" ]
}

# Check if ffmpeg is installed
is_installed ffmpeg || {
	echo "Error: ffmpeg must be installed"
	echo "For mac install with brew"
	echo "brew install ffmpeg"
	exit 1
}

# Grab ext
ext=$(echo "$1" | tr "." "\n" | tail -n 1)
output="output.$ext"

# Run ffmpeg
ffmpeg -i "$1" -filter:v mpdecimate -vsync vfr -c:v libx264 -preset slow -crf 23 -c:a copy "$output" 

# Replace file
rm "$1"
mv "$output" "$1"
