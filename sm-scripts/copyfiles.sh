#!/bin/sh
dir="$(dirname "$0")"
c="$1"
from=$(sh "$dir/commit-base.sh" "$c")
git -c core.quotepath=false diff --name-only --no-renames "$from" "$c" | sh "$dir/toclip.sh"
