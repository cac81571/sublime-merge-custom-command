#!/bin/sh
dir="$(dirname "$0")"
exec 2> "$dir/last.log"
c="$1"
from=$(sh "$dir/commit-base.sh" "$c")
{
  printf '%s\t%s\t%s\t%s\t%s\t%s\n' パス ファイル名 拡張子 状態 追加した行 削除した行
  sh "$dir/diff-detail.sh" "$from" "$c"
} | sh "$dir/toclip.sh"
