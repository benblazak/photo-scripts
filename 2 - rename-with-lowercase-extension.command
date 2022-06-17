#! /usr/bin/env bash

# references
# - https://stackoverflow.com/questions/1489277/how-to-use-prune-option-of-find-in-sh

dir="$(dirname "$0")"

cd "$dir"

find .. -not -path '*/.*'  -not -path '*/-*'  -not -path '*/_*' \
    -type f \
    -exec ./rename-with-lowercase-extension {} \+

echo
echo done
read # pause before closing
