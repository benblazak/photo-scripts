#! /usr/bin/env bash

dir="$(dirname "$0")"

cd "$dir"

echo found

find .. -not -path '*/.*'  -not -path '*/-*'  -not -path '*/_*' \
    -type f \
| perl -pe 's/.*?__(.*)\..*/\1/' \
| perl -pe 's/(IMG_)[a-zA-Z]+([0-9]+)/\1\2/' \
| sort | uniq | wc -l \
| perl -pe 's/\s+/  /'

echo unique filenames

echo
echo done
read # pause before closing
