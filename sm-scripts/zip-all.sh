#!/bin/sh
root=$(basename "$(git rev-parse --show-toplevel)")
n="$root-$(git rev-parse --short "$1")"
z="$USERPROFILE/Desktop/$n.zip"
git archive --format=zip --prefix="$root/" -o "$z" "$1"
explorer /select,"$(echo "$z" | sed 's#/#\\#g')"
true
