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

build : clean $(mUtilScripts)

clean :
	find . -name '*~' -exec rm {} \;

update :
	git co develop
	git pull origin develop

ci checkin : build
	bin/incver.sh -p VERSION
	-git ci -am Update

save push : build
	git co develop
	git pull origin develop
	bin/incver.sh -m VERSION
	-git ci -am Update
	git push --tags origin develop

publish release : save
	bin/incver.sh -M VERSION
	-git ci -am "Inc Ver"
	git tag -f -F VERSION "v$$(cat VERSION)"
	git push --tags origin develop
	git co main
	git pull origin main
	git merge develop
	git push --tags origin main
	git co develop

# --------------------
# Rules

bin/% : $(mUtilDir)/%
	cp $< $@
