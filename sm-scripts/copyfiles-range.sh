#!/bin/sh
dir="$(dirname "$0")"
tmp="$dir/range.$$.tmp"
old=$(powershell.exe -NoProfile -Command Get-Clipboard < /dev/null | tr -d '\r\n ')
if ! git cat-file -e "$old^{commit}" 2>/dev/null; then
  echo "クリップボードにコミットハッシュがありません: $old" | sh "$dir/toclip.sh"
  exit 1
fi
if ! git merge-base --is-ancestor "$old" "$1" 2>/dev/null; then
  echo "クリップボードのコミットは選択コミットの祖先ではありません: $old" | sh "$dir/toclip.sh"
  exit 1
fi
if git rev-parse --verify "$old^" >/dev/null 2>&1; then
  git -c core.quotepath=false log --name-only --format= "$old^..$1"
else
  # ルートコミットを範囲に含める
  git -c core.quotepath=false log --name-only --format= "$old..$1"
  git -c core.quotepath=false diff-tree --no-commit-id --name-only -r "$old"
fi | sort -u > "$tmp"
sh "$dir/toclip.sh" < "$tmp"
rm -f "$tmp"
