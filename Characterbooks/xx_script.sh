#!/bin/bash


files="Assistant.md
CEO.md
Characterlist.md
Empty.md
French_savant.md
Host.md
Luddite.md
Narco_heir.md
Narco_Sicario.md
PM.md
Spouse.md"

for file in $files
do
	sed -i 's/Notes for cross examination of other characters/ Notes for cross examination of other characters/' $file 
done


