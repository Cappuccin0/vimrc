#!/bin/sh
echo Building filelist...
rm cscope.po.out cscope.in.out cscope.out

# Ag mode
ag ./ -i -l -g "" > .ctrlp

# Git mode
#git ls-files > .ctrlp
#git submodule foreach git ls-files >> .ctrlp

echo -n files count: 
cat .ctrlp | wc -l

echo updating tags....
ctags --verbose=no --exclude=.git -R -f .tags -L .ctrlp > /dev/null 2>&1

echo updating cscope database....
cscope -Rbq
