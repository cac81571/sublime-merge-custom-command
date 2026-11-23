#!/bin/sh
dir="$(dirname "$0")"
printf '%s' "$(git rev-parse --short "$1")" | sh "$dir/toclip.sh"
