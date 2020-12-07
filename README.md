# ocarinaBook

We want to create a song book for beginner players of an Ocarina with Lilypond,
where under each note, the fingering on the ocarina is printed as well as
lyrics.

Sample output can be found in the folder `output`.

This is achieved by using the context NoteNames and choosing a custom-made
font, where each letter (cdefga) is a symbol representing the corresponding
fingering on the ocarina.

This can be rather easily adapted to any other ocarina or instrument in
general by creating an appropriate font.

The file `ocarinaBook.ly` just contains references to the individual pieces.
It can be compiled to get the whole book, but each piece can be compiled
individually, too.

Each piece must be a Lilypond file and should define the variable `mel`
containing the melody and the variable `lyr` that should define the lyrics
of the song.
Furthermore, the file `setocarinatune.ly` must be included and then,
after defining the header, the tune is engraved by using `\setorcarinatune`,
which is defined in `setocarinatune.ly` by using the variables `mel` and `lyr`.

The font was created with Inkscape and then, by using FontForge, converted to
a true type font.
