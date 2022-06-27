#! /usr/bin/env bash

# references
# - https://unix.stackexchange.com/questions/406012/manipulate-return-string-from-find-exec
# - https://tldp.org/LDP/abs/html/string-manipulation.html

dir="$(dirname "$0")"

cd "$dir"

find .. -not -path '*/.*'  -not -path '*/-*'  -not -path '*/_*' \
    -maxdepth 1 -type f \
    -exec ./group-by-year {} +

echo
echo done
read # pause before closing
