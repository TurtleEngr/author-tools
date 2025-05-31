# Makefile

# --------------------
# Macros
SHELL=/bin/bash

# my-utility-scripts
mUtilDir=~/bin

mUtilScripts = \
	bin/bash-fmt \
	bin/bash-lint \
	bin/convert-txt2html.sh \
	bin/html-diff \
	bin/incver.sh \
	bin/logit \
	bin/mksymlink \
	bin/org2html.sh \
	bin/rmnl \
	bin/shfmt \
	bin/shunit2 \
	bin/shunit2.1 \
	bin/sort-para.sh \
	bin/tag-collect.sh \

# --------------------
# Main Targets

build : $(mUtilScripts)

# --------------------
# Rules

bin/% : $(mUtilDir)/%
	cp $< $@
