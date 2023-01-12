#!/usr/bin/env bash

source_files=`ls ./*.Rmd`
for f in $source_files
do
    grep -hE '\b(require|library)\(\w+\)' $f | \
    sed '/^[[:space:]]*#/d' | \
    sed -E 's/.*\(([[:alnum:]]*)\).*/\1/' | \
    sort -uf >> lib.txt
done

