#! /usr/bin/env bash

dir="$(dirname "$0")"

base="$(basename "$0")"
base="${base#_}"
base="${base%.*}"

echo --- $0 ---

cd "$dir"
"./${base%.*}"
