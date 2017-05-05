#!/bin/bash

#width="148mm"  # a5
#height="210mm"  # a5
width="149mm"  # 6x4 photo
height="100mm"  # 6x4 photo

# could use getopts here to alter the above settings

[ -z "$1" ] && echo Missing destination PNM file && exit 1
dest="$1"

# the default res is 75, opts found with `scanimage -A`
#echo "Warning: this is pretty low-res"
resolution=300  # 6x4 inch PNM is about 6MB
#resolution=1200  # 6x4 inch PNM is about 100MB

scanimage \
    --progress \
    --resolution $resolution \
    --mode Color \
    -x "$width" \
    -y "$height" \
    > "$dest"

# Missing \n after progress meter
echo

# could scan to /tmp/xxxx.pnm and then use `convert` to make $dest

