#!/bin/bash

# Read all the lines in replacelist_robot.txt and use them to construct sed strings

rm -rf generated
cp -r raw generated

function do_replacings() {
    filename=$1
    while read line;do
            if [ "$line" == "" ]
            then
                continue # skip empty lines
            fi

            # This reads the to_replace and replace_with from the file in the following format:
            # "to_replace:replace_with"

            to_replace=${line%%:*}
            replace_with=${line##*:}

            echo sed -i 's/'"$to_replace"'/'"$replace_with"'/g' "$filename"
            sed -i 's/'"$to_replace"'/'"$replace_with"'/g' "$filename"

    done < replacelist_robot.txt
}



for file in generated/*.md
do
     file_md=${file##*/}
     basename=${file%%.*}

     echo "------------ ${file##*/} ------------"
     do_replacings $file

     echo pandoc -f markdown -t latex -o "$basename".pdf $file
     pandoc -f markdown -t latex --template generated/template.tex -o "$basename".pdf $file
done

rm generated/*.md


# Test to see whether there are any ones we missed:

echo
echo
echo The following are some missed replacements:
echo
find generated -iname "*.md" | xargs grep --color=always -n -E "=[^=]*="
echo
echo Specify values for these values in the 'replacelist_robot.txt' file





