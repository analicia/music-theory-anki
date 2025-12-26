# Music Theory Anki Decks

Anki flashcard decks for learning piano music theory fundamentals, with notation images generated using [LilyPond](https://lilypond.org/).

## Decks Included (10 Total)

| Deck | Cards | Description |
|------|-------|-------------|
| Note Reading - Treble Beginner | 11 | Staff notes + 1 ledger line below (C4-F5) |
| Note Reading - Treble Intermediate | 6 | 2 ledger lines above and below staff |
| Note Reading - Treble Advanced | 15 | Full upper piano range (3+ ledger lines) |
| Note Reading - Bass Beginner | 11 | Staff notes + 1 ledger line above (to Middle C) |
| Note Reading - Bass Intermediate | 6 | 2 ledger lines above and below staff |
| Note Reading - Bass Advanced | 11 | Full lower piano range (3+ ledger lines) |
| Key Signatures - Treble Major | 15 | Major key signatures in treble clef |
| Key Signatures - Treble Minor | 15 | Minor key signatures in treble clef |
| Key Signatures - Bass Major | 15 | Major key signatures in bass clef |
| Key Signatures - Bass Minor | 15 | Minor key signatures in bass clef |

## Quick Start

Just want the decks? Download `decks/music-theory.apkg` and import into Anki.

## Building from Source

### Prerequisites

- [LilyPond](https://lilypond.org/) 2.24+
- [Anki](https://apps.ankiweb.net/)

```bash
# macOS
brew install lilypond

# Verify installation
lilypond --version
```

### Generate Images

```bash
./scripts/build.sh
```

### Import to Anki

1. Copy images from `images/` to Anki's `collection.media` folder
2. File → Import → select CSV files from `csv/`

## Note Reading Ranges

### Treble Clef
| Deck | Range | Notes | Description |
|------|-------|-------|-------------|
| Beginner | C4-F5 | 11 | Staff notes + 1 ledger line below |
| Intermediate | A3, B3, G5-C6 | 6 | 2 ledger lines above and below staff |
| Advanced | E3-G3, F6-C8 | 15 | Full upper piano range (3+ ledger lines) |

### Bass Clef
| Deck | Range | Notes | Description |
|------|-------|-------|-------------|
| Beginner | G2-C4 | 11 | Staff notes + 1 ledger line above (to Middle C) |
| Intermediate | C2-F2, D4-E4 | 6 | 2 ledger lines above and below staff |
| Advanced | A0-B1, F4-G4 | 11 | Full lower piano range (3+ ledger lines) |

**Total: 60 unique note cards** covering the full 88-key piano range (A0-C8)

## Key Signatures Covered

| Sharps | Major | Minor |
|--------|-------|-------|
| 0 | C | A |
| 1 | G | E |
| 2 | D | B |
| 3 | A | F♯ |
| 4 | E | C♯ |
| 5 | B | G♯ |
| 6 | F♯/G♭ | D♯/E♭ |
| 7 | C♯/D♭ | A♯/B♭ |

| Flats | Major | Minor |
|-------|-------|-------|
| 1 | F | D |
| 2 | B♭ | G |
| 3 | E♭ | C |
| 4 | A♭ | F |
| 5 | D♭ | B♭ |
| 6 | G♭/F♯ | E♭/D♯ |
| 7 | C♭ | A♭ |

## Technical Notes

### Staff Width and Spacing

Key signature images use LilyPond's auto-sizing with Scheme overrides for precise, consistent spacing:

**Paper Settings:**
- `page-breaking = #ly:one-line-auto-height-breaking` - Auto-sizes pages to content
- Margins: 3mm top/bottom, 2mm left/right
- `top-system-spacing` and `top-markup-spacing` tuned to prevent clef cutoff
- No cropping needed - LilyPond handles layout natively

**Spacing Control:**
- `\override Score.SpacingSpanner.spacing-increment = #1.5` - Fine-grained horizontal spacing control
- `s\breve` - Invisible spacer (2 whole notes duration)
- Result: **416px wide** images with balanced margins, optimized for phone screens

The `spacing-increment` value (1.5) provides comfortable spacing for keys with many accidentals (e.g., C♯ major with 7 sharps) while maintaining uniform width so students can't use staff length as a clue. Images include proper margins making them ready to use without additional cropping or post-processing.

## Planned

- **Key signature counting** - "How many sharps/flats in F♯ minor?" → "3 sharps"
- **Key identification by count** - "Which minor key has 3 sharps?" → "F♯ minor"
- **Basic music theory** - Circle of fifths, intervals, scales, etc.

## License

MIT
