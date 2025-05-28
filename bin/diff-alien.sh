#!/usr/bin/bash -x

if [ $# -ne 1 ]; then
    cat <<EOF
Usage:
    diff-alien.sh VER
Example
    diff-alien.sh 1.483
Bugs
    Nice try, but differences are missed in places and often text is
    marked as "deleted" when it has not been deleted.
EOF
    exit 1
fi

# PP
#cTidy='tidy -m -config ~/profile/tidy/tidywp.conf'
# word
cTidy='tidy -m -config ~/profile/tidy/tidyxhtml-narrow.conf'

pVer=$1
if [[ "$PWD" != '/home/bruce/ver/local/project/book-humane/draft' ]]; then
    echo "Not in draft dir"
    exit 1
fi

if ! cvs update; then echo Error; exit 1; fi
if ! cvs ci -m "Updated"; then echo Error; exit 1; fi
make gen/alien.css

make quick
mv gen/alien.html gen/alien-cur.html

if ! cvs update -r $pVer alien.org; then echo Error; exit 1; fi
make quick
mv gen/alien.html gen/alien-old.html
cvs update -A alien.org
make quick

cd gen
$cTidy alien-cur.html
$cTidy alien-old.html
#tidy -m -config ~/profile/tidy/tidywp.conf alien-cur.html
#tidy -m -config ~/profile/tidy/tidywp.conf alien-old.html
html-diff alien-old.html alien-cur.html alien-diff.html

sensible-browser ./alien-diff.html
cd -
