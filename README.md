# Music Theory Anki Decks

Anki flashcard decks for learning music theory fundamentals, with notation images generated using [LilyPond](https://lilypond.org/).

## Decks Included

| Deck | Description |
|------|-------------|
| Note Reading - Treble Clef | Identify notes on the treble clef staff |
| Note Reading - Bass Clef | Identify notes on the bass clef staff |
| Key Signatures - Major | Recognize major key signatures |
| Key Signatures - Minor | Recognize minor key signatures |
| Theory Trivia | Circle of fifths, scales, and other fundamentals |

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

## License

MIT
