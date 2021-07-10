#!/usr/bin/env sh

# script to add a border to an image

image=$1
border_color=$2
border_width=$3

# temp directory
dir=$PWD
temp_dir=$PWD/temp_add_border/
mkdir $temp_dir
cp $image $temp_dir
cd $temp_dir

# add more space at edge
convert $image -bordercolor none -border 10 larger.png

# get mask of shape
convert larger.png -compose Dst_In -border 0 background.png

# dilate the mask for use as background
convert background.png -morphology Dilate Disk:$border_width -fill $border_color -colorize 100 dilate.png

# overlay logo on mask
composite -gravity center $image dilate.png image_border.png

# clean up
mv image_border.png $dir/${image%.*}_border.png
cd $dir
rm -r $temp_dir
