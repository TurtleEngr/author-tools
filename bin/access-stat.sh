#!/bin/bash
# Who has accessed my book draft files?
# Usage:
#    ./access-stat.sh [N] >access.csv

export gpNumDay=30
if [[ $# -eq 1 ]]; then
    gpNumDay=$1
fi

export cLog=/var/log/apache2/moria.access.log
export cLogOld='/var/log/apache2/old/moria.access.log'
export cDirList='rel/development/doc/own/aliens|rel/released/doc/own/bib/|rel/released/doc/own/alien'
export cIgnore='/image|\?C='

if [[ ! -r $cLog ]]; then
    echo "Error: $cLog is not readable."
    exit 1
fi
rm /tmp/access-stat.*
if [[ -f /tmp/access-stat.awk ]]; then
    echo "Error: /tmp/access-stat.awk is not writable."
    exit 1
fi

cat <<\EOF >/tmp/access-stat.awk
BEGIN {
    months["Jan"] = "01";
    months["Feb"] = "02";
    months["Mar"] = "03";
    months["Apr"] = "04";
    months["May"] = "05";
    months["Jun"] = "06";
    months["Jul"] = "07";
    months["Aug"] = "08";
    months["Sep"] = "09";
    months["Oct"] = "10";
    months["Nov"] = "11";
    months["Dec"] = "12";
}
{
    # Match the date pattern
    if (match($0, /\[([0-9]{2})\/([A-Za-z]{3})\/([0-9]{4}):([0-9]{2}:[0-9]{2}:[0-9]{2})/, arr)) {
        day = arr[1];
        month = months[arr[2]];
        year = arr[3];
        time = arr[4];
        # Replace the old date with the new format
        sub(/ \[[^ ]* /, " " year "-" month "-" day ":" time " ");
    }

    printf("%s,%s,%s,%s", $4,$3,$7,$1);
    gsub(/"/,"'");
    $1 = "";
    $2 = "";
    $3 = "";
    $4 = "";
    $5 = "";
    $6 = "";
    $7 = "";
    $8 = "";
    $9 = "";
    $10 = "";
    $11 = "";
    gsub(/^ */,"")
    printf(",\"%s\"\n", $0);
}
EOF

# ========================================

for f in $cLog $('ls' -1tr ${cLogOld}-* | tail -n $gpNumDay); do 
    if [[ ${f} = ${f%.gz} ]]; then
        awk -f /tmp/access-stat.awk <$f
    else
        gunzip <$f | awk -f /tmp/access-stat.awk
    fi
done | grep -E "$cDirList" | grep -Ev $cIgnore  >/tmp/access-stat.csv

echo "0-Date,User,URL,IP,Browser" >>/tmp/access-stat.csv
sort -u /tmp/access-stat.csv
