
% define the actual melody of the piece in a variable mel
% Transposing the melody to a key that can be played by the ocarina
mel = \transpose f c {
 \relative c' { \clef violin \numericTimeSignature \time 2/4 \key f \major
  f4 g a bes c d c bes
  \bar "|."}
  }

% define the actual lyrics to the piece in a variable lyr
lyr = \lyricmode {
  This is just a de -- mon -- stra -- tion.
}

% Now we
\include "setocarinatune.ly"
% in order to get the variable setocarinatune which can engrave the whole
% piece. It used the previously defined variables mel and lyr.

% Now we start engraving!
\bookpart {
  % define the header
  \header {
    title = "Demonstration"
  }

  % actually engrave the piece
  \setocarinatune
}
