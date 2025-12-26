\version "2.24.0"

\paper {
  indent = 0
  page-breaking = #ly:one-line-auto-height-breaking
  top-margin = 3\mm
  bottom-margin = 3\mm
  left-margin = 2\mm
  right-margin = 2\mm
  top-system-spacing = #'((basic-distance . 1) (minimum-distance . 0) (padding . 0))
  top-markup-spacing = #'((basic-distance . 0) (minimum-distance . 0) (padding . 0))
}

\header {
  tagline = ##f
}

{
  \clef bass
  \omit Staff.TimeSignature
  \omit Staff.BarLine
  g1
}
