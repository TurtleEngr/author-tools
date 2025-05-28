#!/bin/bash
# Remove major section parts from headings.
# For example:
   # ../bin/rm-prefix.sh <alien.org >alien2.org
   # grep '^\*' alien.org
   # grep '^\*' alien2.org

sed '
s/ I*\.[A-H]\.\([1-9]\. .*\)/ \1/
s/ I*\.\([A-H]\. .*\)/ \1/
'
