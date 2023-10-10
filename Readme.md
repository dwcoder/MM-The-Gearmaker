# Info

This is a murder mystery for 8 players, where the names/pronouns can be changed programmatically for most of the characters.

For a compiled, playable game with PDFs using all the default character names, see the [releases](https://github.com/dwcoder/MM-The-Gearmaker/releases).

## Customisation

To generate the game with your own character names and pronouns, complete the instructions below, in order.
I recommend using your guests' actual names. That way, everyone just has to learn one set of names at the party.


1. Assign the characters to the actual people in `character assign.txt`.
2. Do all the replacements in the `pronouns_and_replacments.txt`. Use people's actual names to make things easier. There are some defaults in there which you can run to generate a working game.
3. Change the text in `Newspaper.md` to reflect the date and location (this is the invite)
4. Run `generate_game.sh` in bash.
5. The generated files are all in the `_generated_game` folder
6. (Optional) Run `Character_assign.sh`, which will create a file called `Character assign Generated.txt` with all the names of the participants


## Requirements

Requires bash and `pandoc` (with Latex) for the scripts to run.
