#!/bin/sh
# Convert a recording to Opus 48 kbps for the AZEBUCHE archive and print
# the length and size to paste into the editing panel.
#
#   sh tools/azebuche/encode-audio.sh input.wav [output.opus]
#
# Needs ffmpeg and ffprobe. Upload the master and the .opus to archive.org.
set -e

in="$1"
out="${2:-${in%.*}.opus}"
[ -f "$in" ] || { echo "usage: $0 input.wav [output.opus]" >&2; exit 1; }

ffmpeg -hide_banner -loglevel error -y -i "$in" -vn -c:a libopus -b:a 48k -vbr on "$out"

secs=$(ffprobe -v error -show_entries format=duration -of default=nw=1:nk=1 "$out")
bytes=$(wc -c < "$out")

awk -v s="$secs" -v b="$bytes" -v f="$out" 'BEGIN {
  s = int(s + 0.5)
  if (s >= 3600) d = sprintf("%d:%02d:%02d", s / 3600, (s % 3600) / 60, s % 60)
  else           d = sprintf("%d:%02d", s / 60, s % 60)
  if (b >= 1000000) z = sprintf("%.1f MB", b / 1000000)
  else              z = sprintf("%d KB", b / 1000 + 0.5)
  print f
  print "Length:    " d
  print "File size: " z
}'
