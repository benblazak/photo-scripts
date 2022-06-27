#! /usr/bin/env bash

# references
# - https://unix.stackexchange.com/questions/406012/manipulate-return-string-from-find-exec
# - https://tldp.org/LDP/abs/html/string-manipulation.html

dir="$(dirname "$0")"

cd "$dir"

find .. -not -path '*/.*'  -not -path '*/-*'  -not -path '*/_*' \
    -maxdepth 1 -type f \
    -exec bash -c '
        for file do
            dir=$(basename "$file")
            dir="../${dir:0:4}"
            mkdir -p "$dir"
            mv -i "$file" "$dir"
        done' bash {} +

echo
echo done
read # pause before closing
