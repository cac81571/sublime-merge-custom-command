#!/bin/sh
c="$1"
p="$2"
d="$USERPROFILE/Desktop/$(basename "$(git rev-parse --show-toplevel)")-$(git rev-parse --short "$c")"
for s in before after; do
  if [ "$s" = before ]; then
    git rev-parse --verify "$c^" >/dev/null 2>&1 || continue
    r="$c^"
  else
    r="$c"
  fi
  if git cat-file -e "$r:$p" 2>/dev/null; then
    mkdir -p "$d/$s/$(dirname "$p")"
    git show "$r:$p" > "$d/$s/$p"
  fi
done
explorer "$(echo "$d" | sed 's#/#\\#g')"
true
