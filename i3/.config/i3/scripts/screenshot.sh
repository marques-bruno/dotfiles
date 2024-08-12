#!/bin/bash

OUTPUT_FOLDER=~/Pictures/screenshots
TIME=$(date +"%Y-%m-%d-%T") 

mkdir -p $OUTPUT_FOLDER
scrot $OUTPUT_FOLDER/$TIME-screenshot.png
notify-send "Screenshot saved to $OUTPUT_FOLDER/$TIME-screenshot.png"
