
% Set up the paper
\paper {
  % Paper size
  #(set-paper-size "a5")

  % We want one-sided output, meaning that we use left and right margin instead
  % of inner and outer margin
  two-sided = ##f

  % Increase distance between two lines
  system-system-spacing = #'((padding . 4))

  % Increase the distance between song title and first line
  markup-system-spacing  = #'((padding . 4))

  % Set up the headers and footers:
  % Footers should always have the page number on the right
  evenFooterMarkup = \markup { \fill-line { \null \fromproperty #'page:page-number-string } }
  oddFooterMarkup = \markup { \fill-line { \null \fromproperty #'page:page-number-string } }
  % Headers should always be empty
  evenHeaderMarkup = \markup { }
  oddHeaderMarkup = \markup { }

  % Set up the margins
  left-margin = 2\cm
  right-margin = 1\cm
  top-margin = 1\cm
  bottom-margin = 1\cm
}

% Add all fonts in the directory
#(ly:font-config-add-directory "font/")

% Here we define note names that should be used instead of the standard
% note names (which seem to be hardcoded to be in Dutch for some reason?)
% We have to make sure that the letters in the right column match the correct
% fingerings in the font (here: OcarinaVierLoch.ttf).
newnames =
#`(("c'" . "c")
   ("d'" . "d")
   ("e'" . "e")
   ("f'" . "f")
   ("g'" . "g")
   ("a'" . "a")
   ("b'" . "h"))

% This seems to be a replacement function which I've taken from Valentin Villenave:
% https://lists.gnu.org/archive/html/lilypond-user/2010-10/msg00687.html
myNoteNames =
#(lambda (grob)
   (let* ((default-name (ly:grob-property grob 'text))
          (new-name (assoc-get default-name newnames)))
         (ly:grob-set-property! grob 'text new-name)
   (ly:text-interface::print grob)))

% Now we define a variable that when called by \setocarinatune engraves
% the piece.
                 % create a score with staff and lyrics
setocarinatune = \score { <<
     % A voice which is the melody
     \new Voice = melody {
       <<
         % consting of the actual melody that is stored in the variable mel
         \mel
         % And the note names
         \context NoteNames {
           % align the center of the note names with the center of the note
           % heads
           \override NoteName.X-offset = #ly:self-alignment-interface::aligned-on-x-parent
           \override NoteName.self-alignment-X = #CENTER

           % We want to print the octaves
           \set printOctaveNames = ##t

           % We use the custom font OcarinaVierLoch
           \override NoteName.font-name = "OcarinaVierLoch"

           % Set the font size
           \override NoteName.font-size = #10

           % And use the replacement function from earlier
           \override NoteName #'stencil = #myNoteNames

           % And now the melody again in the NoteNames context
           \mel
         } % end of context NoteNames
       >> % end of Voice
     }

     % Now for some Lyrics:
     \new Lyrics
       \lyricsto melody {
         % We could override the font for the lyrics, but I chose not to
         %\override Lyrics.LyricText.font-name = "Comic Sans MS"

         % Increase the distance under the lyrics, so they are not too close
         % to the next staff
         \override VerticalAxisGroup.nonstaff-unrelatedstaff-spacing = #'((basic-distance . 10))

         % The actual lyrics inside this variable
         \lyr
     } % end of Lyrics
   >>

   % Give a layout output
   \layout { }

   % Give a midi output
   \midi { }
} % end of score
