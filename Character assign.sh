#!/bin/bash

# Read all the lines in replacelist_robot.txt and use them to construct sed strings

workdir=$(pwd)

abs_replace_list_file=$workdir/replacelist_robot.txt

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

    done < $abs_replace_list_file
}



cp "Character assign.txt" "generated/Character assign.txt"
do_replacings "generated/Character assign.txt"
