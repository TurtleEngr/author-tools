#!/bin/bash
# Fix older style citations with newer style.

sed '
    s/\({[a-z][a-z]*-[0-9][0-9]*\)}\(:p[0-9][0-9]*\)/\1\2}/g
    s/\({[a-z][a-z]*-[0-9][0-9]*\)}\(:loc[0-9][0-9]*\)/\1\2}/g
' <alien.org
