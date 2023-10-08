# Info

This is a murder mystery for 8 players, where the names/pronouns can be changed programmatically for most of the characters.

To generate the game, complete the instructions in the following order:


1. Assign the characters to the actual people in `character assign.txt`.
2. Do all the replacements in the pronouns_and_replacments.txt. Use people's actual names to make things easier.
3. Change the text in Newspaper.md to reflect the date and location (this is the invite)
4. Run `generate_game.sh`.
5. Run Character_assign.sh, which will create a file called `Character assign Generated.txt` with all the names of the participants
6. The generated files are all in the "Generated" folder


## Requirements

Requires bash and `pandoc` (with Latex) for the scripts to run.
