#!/bin/bash
# Count the number of words in each blockquote.

cat <<\EOF >tmp.awk
BEGIN {
  gIn = 0
  gText = ""
}
/<blockquote>/ {
  gIn = 1
  gLine = NR
  gText = ""
#  system("rm b.tmp >/dev/null 2>&1")
}
gIn == 1 {
  gText = gText " " $0
}
/<\/blockquote>/ {
  gIn = 0
  if (length(gText) != 0) {
    printf "%s ", gLine
    print gText > "b.tmp"
    system("/usr/bin/wc -w < b.tmp")
    close("b.tmp")
  }
  gText = ""
}
{ next }
EOF

awk -f tmp.awk | sort -n -k 2
rm tmp.awk b.tmp
