#!/bin/sh
dir="$(dirname "$0")"
tmp="$dir/clip.$$.tmp"
cat > "$tmp"
w=$(cd "$dir" && pwd -W)/$(basename "$tmp")
powershell.exe -NoProfile -Command "Get-Content -Encoding UTF8 -Raw '$w' | Set-Clipboard" < /dev/null
rm -f "$tmp"
