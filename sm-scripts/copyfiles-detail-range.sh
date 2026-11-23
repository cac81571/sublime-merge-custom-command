#!/bin/sh
dir="$(dirname "$0")"
old=$(powershell.exe -NoProfile -Command Get-Clipboard < /dev/null | tr -d '\r\n ')
if ! git cat-file -e "$old^{commit}" 2>/dev/null; then
  echo "クリップボードにコミットハッシュがありません: $old" | sh "$dir/toclip.sh"
  exit 1
fi
if ! git merge-base --is-ancestor "$old" "$1" 2>/dev/null; then
  echo "クリップボードのコミットは選択コミットの祖先ではありません: $old" | sh "$dir/toclip.sh"
  exit 1
fi
from=$(sh "$dir/commit-base.sh" "$old")
to="$1"
{
  printf '%s\t%s\t%s\t%s\t%s\t%s\n' パス ファイル名 拡張子 状態 追加した行 削除した行
  sh "$dir/diff-detail.sh" "$from" "$to"
} | sh "$dir/toclip.sh"
