#! /usr/bin/env bash

# references
# - https://stackoverflow.com/questions/1489277/how-to-use-prune-option-of-find-in-sh

dir="$(dirname "$0")"

cd "$dir"

find .. -not -path '*/.*'  -not -path '*/-*'  -not -path '*/_*' \
    -type f -not -iname '*.xmp' \
    -exec ./rename-with-date {} \+
find .. -not -path '*/.*'  -not -path '*/-*'  -not -path '*/_*' \
    -type f -iname '*.xmp' \
    -exec ./rename-with-date {} \+

echo
echo done
read # pause before closing
