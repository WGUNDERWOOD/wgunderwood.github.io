#!/usr/bin/env sh

# script to download and format my cv

# git root directory
root_dir=$(git rev-parse --show-toplevel)

# download my current cv
wget --quiet --output-document $root_dir/assets/files/WGUnderwood.pdf https://github.com/WGUNDERWOOD/wgu-cv/raw/master/WGUnderwood.pdf
