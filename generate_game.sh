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
}


folders="Characterbooks
Newspaper
Readme"

rm -rf $output_folder 
mkdir $output_folder

for foldername in $folders
do
    cp -r $foldername $output_folder/$foldername
done


# Put the general rules in the character books folder, so it can be included
pandoc -f markdown -t latex -o ./$output_folder/Characterbooks/rules.tex General_Rules.md



for foldername in $folders
do
    echo cd "$workdir"/$output_folder/$foldername
    cd "$workdir"/$output_folder/$foldername
    for file in *.md
    do

        basename=${file%.*}


        echo "------------ ${file##*/} ------------"
        do_replacings $file

        echo pandoc -f markdown -t latex -o "$basename".pdf $file
        pandoc -f markdown -t latex --template="template.tex" -o "$basename".pdf $file

    done

done

cd $workdir

# Make the placemats
foldername="Placecards"
cp -r $foldername $output_folder/$foldername
echo cd "$workdir"/$output_folder/$foldername
cd "$workdir"/$output_folder/$foldername
for file in *.tex
do

    basename=${file%.*}

    echo "------------ ${file##*/} ------------"
    do_replacings $file

    pdflatex $file > pdflatex.log

done



cd $workdir
# Make the script to rename the files
cp pdf_rename_script_raw.txt pdf_rename_script_generated.sh
do_replacings pdf_rename_script_generated.sh
chmod +x pdf_rename_script_generated.sh

# Run the pdf rename script inside the characterbooks folder
echo
echo Renaming pdf files of characterbooks...
cd "$workdir"/$output_folder/Characterbooks
$workdir/pdf_rename_script_generated.sh
echo Done
echo


# Copy the art assets to the $output_folder
cd $workdir
echo
echo Copy the evidence art assets to $output_folder
echo
mkdir $output_folder/Evidence_pieces
cp art_assets/Evidence_piece_1.pdf $output_folder/Evidence_pieces




cd $workdir
# Test to see whether there are any ones we missed:
echo
echo
echo -------------------------------------------------------------------------
echo The following are some missed replacements:
echo
find ./$output_folder -iname "*.md" | xargs grep --color=always -n -E "=[^=]*="
echo
echo Specify values for these values in '$abs_replace_list_file'
echo -------------------------------------------------------------------------
echo All done


find ./$output_folder -iname "*.md" | xargs rm




