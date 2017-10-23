#!/bin/bash

# Enable the alias that allows me to always get colours
shopt -s expand_aliases
alias 'grep'='grep --color=always'

#grep -i -n --color=always -E "[^a-z]$1 $1[^a-z]" *.tex

# A better script that doesn't need a list of words
find . -iname "*.md" | grep -r -nE " ([a-z].*[a-z]) \1 "
