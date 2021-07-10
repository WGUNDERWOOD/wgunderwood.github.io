#!/usr/bin/env sh

# script to download and format my cv

# git root directory
root_dir=$(git rev-parse --show-toplevel)

# download my current cv
wget --quiet --output-document $root_dir/assets/files/WGUnderwood.pdf https://github.com/WGUNDERWOOD/wgu-cv/raw/master/WGUnderwood.pdf

# get first page of cv
pdftk $root_dir/assets/files/WGUnderwood.pdf cat 1 output $root_dir/assets/files/WGUnderwood_page_1.pdf

# get thumbnail of first page of cv
convert $root_dir/assets/files/WGUnderwood_page_1.pdf -resize 1000x250 -colorspace gray -flatten $root_dir/assets/graphics/general/cv_thumbnail.png

# clean up files
rm $root_dir/assets/files/WGUnderwood_page_1.pdf
