#!/bin/bash

# Read all the lines in replacelist_robot.txt and use them to construct sed strings

workdir=$(pwd)
output_folder='_generated_game'
abs_replace_list_file=$workdir/pronouns_to_replace.txt

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

    # Remove the (male) (female) in the brackets
    echo sed -i 's/([^)]*)//g' "$filename"
    sed -i 's/([^)]*)//g' "$filename"
}



cp "Character assign.txt" "$output_folder/Character assign.txt"
do_replacings "$output_folder/Character assign.txt"
