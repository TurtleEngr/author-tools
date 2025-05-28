# Make a concordance file for libreoffice, for author locations in a document.
# https://help.libreoffice.org/7.6/en-US/text/swriter/01/04120250.html?&DbPAR=SHARED&System=UNIX

# Search terms are values {Id}, Author:, Title:
# Usage:
#     awk -f ../bin/mk-index.awk ref-biblio.txt | sort -iu >ref-index.sdi

function fIndex(pSearch, pAlt, pMain, pCase, pSingle) {
    print pSearch ";" pAlt ";" pMain ";;" pCase ";" pSingle
} # fIndex

function fOutput() {
    # search;Alt-Entry;Main-Category;Comment;Case-sensitive?;Single-word?
    fIndex(gId, gAuthor, "", 1, 0)
    fIndex(gLast, gAuthor, "", 1, 1)
    fIndex(gFirst " " gLast, gAuthor, "", 1, 0)
    fIndex(gTitle, gAuthor, "", 1, 0)
    print ""
} # fOutput

BEGIN {
    gId="";
    gTitle="";
    gAuthor="";
}

END {
    if (gId && gAuthor && gTitle)
        fOutput()
}

/^{/ {
    gNextId = $0
    sub("{", "", gNextId)
    sub("}", "", gNextId)
    if (gId && gAuthor && gTitle)
        fOutput()
    gId = gNextId
    gTitle = ""
    gAuthor = ""
    next
}
/Title: / {
    gTitle = $0
    sub("Title: ", "", gTitle)
    next
}
/Author: / {
    gAuthor = $0
    sub("Author: ", "", gAuthor)
    gLast = $2
    sub(",", "", gLast)
    gFirst = $0
    sub("Author: ", "", gFirst)
    sub(".*, ", "", gFirst)
    next;
}
