#!/bin/sh
# usage: diff-detail.sh <from> <to>
from="$1"
to="$2"
dir="$(dirname "$0")"
stf="$dir/status.$$.tmp"
git -c core.quotepath=false diff --no-renames --name-status "$from" "$to" > "$stf"
git -c core.quotepath=false diff --no-renames --numstat "$from" "$to" | while IFS="$(printf '\t')" read -r add del p; do
  [ -n "$p" ] || continue
  st=$(awk -F'\t' -v p="$p" '$2 == p { print substr($1,1,1); exit }' "$stf")
  case "$st" in A) s=追加;; D) s=削除;; M) s=変更;; *) s="$st";; esac
  f=$(basename "$p")
  case "$f" in *.*) e=".${f##*.}";; *) e="";; esac
  printf '%s\t%s\t%s\t%s\t%s\t%s\n' "$p" "$f" "$e" "$s" "$add" "$del"
done
rm -f "$stf"
