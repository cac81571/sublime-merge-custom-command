#!/bin/sh
dir="$(dirname "$0")"
c="$1"
d="$USERPROFILE/Desktop/$(basename "$(git rev-parse --show-toplevel)")-$(git rev-parse --short "$c")"
from=$(sh "$dir/commit-base.sh" "$c")
# ルートコミットのとき from は空ツリー。before は作らない
has_parent=0
git rev-parse --verify "$c^" >/dev/null 2>&1 && has_parent=1
git -c core.quotepath=false diff --name-only --no-renames "$from" "$c" | while IFS= read -r p; do
  [ -n "$p" ] || continue
  for s in before after; do
    if [ "$s" = before ]; then
      [ "$has_parent" -eq 1 ] || continue
      r="$from"
    else
      r="$c"
    fi
    if git cat-file -e "$r:$p" 2>/dev/null; then
      mkdir -p "$d/$s/$(dirname "$p")"
      git show "$r:$p" > "$d/$s/$p"
    fi
  done
done
explorer "$(echo "$d" | sed 's#/#\\#g')"
true
