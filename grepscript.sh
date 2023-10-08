#!/bin/bash

# Use this script to check for any pronouns that you may have forgotten to make placeholders

#find . -iname "*.md" -print0 | xargs -0 grep -E "[^=[:alpha:]][SHsh]e " --colour=always
find . -iname "*.md" -print0 | xargs -0 grep -E "[^=[:alpha:]][SHsh][ei][ ms][ .]" --colour=always

