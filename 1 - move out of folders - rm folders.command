#! /usr/bin/env bash

# references
# - https://stackoverflow.com/questions/1489277/how-to-use-prune-option-of-find-in-sh

dir="$(dirname "$0")"

cd "$dir"

find .. -not -path '*/.*'  -not -path '*/-*'  -not -path '*/_*' \
    -mindepth 2 -type f \
    -exec mv {} .. \;
find .. -not -path '*/.*'  -not -path '*/-*'  -not -path '*/_*' \
    -type d -empty \
    -delete

echo
echo done
read # pause before closing
