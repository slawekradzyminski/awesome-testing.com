#!/usr/bin/env bash
set -euo pipefail

usage() {
  cat <<'EOF'
Usage: scripts/resize-images.sh [max_width_px] <image>...

Defaults to max_width_px=1400. Each image is resized in-place with macOS sips
while keeping aspect ratio. Images already at or below the target width are
left untouched.
EOF
}

if [[ $# -lt 1 ]]; then
  usage
  exit 1
fi

if ! command -v sips >/dev/null 2>&1; then
  echo "error: sips command not available (macOS only)" >&2
  exit 1
fi

max_width=1400
if [[ $1 =~ ^[0-9]+$ ]]; then
  max_width=$1
  shift
fi

if [[ $# -lt 1 ]]; then
  echo "error: no image paths provided" >&2
  usage
  exit 1
fi

get_dims() {
  local file=$1
  sips -g pixelWidth -g pixelHeight "$file" | awk -F': ' '
    /pixelWidth/ {w=$2+0}
    /pixelHeight/ {h=$2+0}
    END {print w " " h}
  '
}

for img in "$@"; do
  if [[ ! -f $img ]]; then
    echo "skip: $img (missing)"
    continue
  fi

  read -r width height <<<"$(get_dims "$img")"

  if (( width == 0 )); then
    echo "skip: $img (unsupported format?)"
    continue
  fi

  if (( width <= max_width )); then
    echo "skip: $img already <= ${max_width}px (current ${width}px)"
    continue
  fi

  base="${img##*/}"
  if [[ $base == *.* ]]; then
    ext="${base##*.}"
  else
    ext=""
  fi
  tmpbase=$(mktemp "/tmp/resize.XXXXXX")
  if [[ -n $ext ]]; then
    tmpfile="${tmpbase}.${ext}"
  else
    tmpfile="${tmpbase}"
  fi
  mv "$tmpbase" "$tmpfile"
  lc_ext=$(printf '%s' "$ext" | tr '[:upper:]' '[:lower:]')
  if [[ $lc_ext == "png" ]]; then
    sips --setProperty formatOptions 1 --resampleWidth "$max_width" "$img" --out "$tmpfile" >/dev/null
  else
    sips --resampleWidth "$max_width" "$img" --out "$tmpfile" >/dev/null
  fi
  mv "$tmpfile" "$img"
  if command -v pngquant >/dev/null 2>&1; then
    if ! pngquant --force --skip-if-larger --speed 2 --quality 70-95 --output "$img" "$img" >/dev/null 2>&1; then
      :
    fi
  fi
  read -r new_width new_height <<<"$(get_dims "$img")"
  bytes=$(wc -c <"$img")
  echo "resized: $img -> ${new_width}x${new_height}px (${bytes} bytes)"
done
