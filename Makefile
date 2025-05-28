# Makefile

SHELL=/bin/bash

mUtil = bash-fmt,bash-lint,convert-txt2html.sh,html-diff,incver.sh,logit,mksymlink,org2html.sh,rmnl,shfmt,shunit2*,sort-para.sh,tag-collect.sh

build :
	rsync ~/bin/{$(mUtil)} bin/
