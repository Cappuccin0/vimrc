#!/bin/sh
echo Building filelist...
rm cscope.po.out cscope.in.out cscope.out > /dev/null 2>&1

if [ -r ".ctrlp_cust" ]
then
    rm -f .ctrlp > /dev/null
    for line in `cat .ctrlp_cust`;
    do
        ag $line -ilg "" >> .ctrlp
    done
else
    # Ag mode
    ag ./ -i -l -g "" > .ctrlp
fi

exit 0

# Git mode
#git ls-files > .ctrlp
#git submodule foreach git ls-files >> .ctrlp

echo -n files count: 
cat .ctrlp | wc -l

echo updating tags....
ctags --verbose=no --exclude=.git -R -f .tags -L .ctrlp > /dev/null 2>&1

echo updating cscope database....
cscope -Rbq
