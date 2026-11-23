#!/bin/sh
# usage: commit-base.sh <commit>
# prints first parent, or empty tree if root commit
c="$1"
if b=$(git rev-parse --verify "$c^" 2>/dev/null); then
  printf '%s\n' "$b"
else
  git hash-object -t tree /dev/null
fi
