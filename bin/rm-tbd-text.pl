#!/usr/bin/perl
# Generated with ChatGPT
# Prompts:
# 1. Write a perl script that will remove text, from standard in, that
#    begins with "[TBD" and ends with "]"
# 2. Correction: the text to be matched can cross muliple lines.  

# This version of the script reads the entire input at once using
# local $/; which sets the input record separator to undef,
# effectively reading the entire input until EOF. Then, it applies the
# regex substitution with the /s modifier to allow . to match newline
# characters, ensuring that the pattern can match text spanning
# multiple lines. Finally, it prints the modified input.

# Usage:
# ../bin/rm-tbd-text.pl <alien.org >alien-no-tbd.org

use strict;
use warnings;

# Slurp the entire input
local $/;

# Read the whole input
my $input = <STDIN>;

# Remove text starting with "[TBD" and ending with "]"
$input =~ s/\[TBD.*?\]//gs;

# Print the modified input
print $input;
