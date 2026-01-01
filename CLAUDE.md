# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

Music theory Anki flashcard deck generator that uses LilyPond to create music notation images. The generated images are used to create Anki decks for learning music theory fundamentals.

## Prerequisites

- LilyPond 2.24+ (install via `brew install lilypond` on macOS)
- Anki (for importing the final decks)

## Build System

### Primary Build Command

```bash
./scripts/build.sh
```

This compiles all LilyPond (.ly) files to PNG images at 400 DPI resolution with auto-sized pages.

### Build Process Flow

1. The build script (`scripts/build.sh`) scans `src/` for `.ly` files
2. LilyPond compiles each file to PNG using `--png -dresolution=400`
3. Files use `ly:one-line-auto-height-breaking` with tuned spacing to auto-size pages
4. Output organized in `images/` mirroring the source structure

## Architecture

### Directory Structure

```
src/
├── key-signatures/
│   ├── treble-major/  # Treble clef major key signature .ly files
│   ├── treble-minor/  # Treble clef minor key signature .ly files
│   ├── bass-major/    # Bass clef major key signature .ly files
│   └── bass-minor/    # Bass clef minor key signature .ly files
└── note-reading/
    ├── treble/        # Treble clef note reading .ly files
    └── bass/          # Bass clef note reading .ly files

images/                # Mirrors src/ structure exactly
├── key-signatures/
│   ├── treble-major/
│   ├── treble-minor/
│   ├── bass-major/
│   └── bass-minor/
└── note-reading/
    ├── treble/
    └── bass/

csv/                   # CSV files for Anki import
```

### LilyPond File Structure

All `.ly` files follow a consistent pattern:

**Key Signatures**: Use `\key <note> \major` or `\key <note> \minor` with `\omit Staff.TimeSignature` and `\omit Staff.BarLine`, displaying only the staff and key signature. Layout is controlled via:
- `page-breaking = #ly:one-line-auto-height-breaking` - Auto-sizes page to content
- Margins: 3mm top/bottom, 2mm left/right
- `top-system-spacing` and `top-markup-spacing` - Tuned to prevent clef cutoff
- `\override Score.SpacingSpanner.spacing-increment = #1.5` - Fine-grained horizontal spacing
- `s\breve` - Invisible spacer (2 whole notes duration)
- Produces consistent **416px wide** images with balanced margins

**Note Reading**: Display a single note on the staff with defined paper width (`line-width = 3\cm`).

Common settings across all files:
- Version: "2.24.0"
- Paper: `indent = 0`, auto-sized with specific margins
- Header: `tagline = ##f` (removes LilyPond footer)

**Spacing Philosophy**: All key signature images maintain uniform 416px width (optimized for phone screens) so students can't use staff length as a clue. The auto-height breaking eliminates the need for post-processing cropping. See README.md Technical Notes for details.

### Build Script Functions

The build script has two main compilation functions:

1. `compile_key_signatures <subdir>`: Compiles key signature files from `src/key-signatures/<subdir>` to `images/key-signatures/<subdir>`. Called four times for treble-major, treble-minor, bass-major, and bass-minor.

2. `compile_notes <clef>`: Compiles note reading files from `src/note-reading/<clef>` to `images/note-reading/<clef>`.

Both functions suppress LilyPond stderr output (`2>/dev/null`) for cleaner build logs and automatically count files before processing.

## Adding New Content

### Adding a Key Signature

1. Create `.ly` file in `src/key-signatures/{treble|bass}-{major|minor}/`
2. Name using pattern: `{note}-{major|minor}.ly` (e.g., `g-sharp-minor.ly`)
3. Use standard key signature template with appropriate `\key` directive
4. Run `./scripts/build.sh` to generate image in matching `images/key-signatures/` subdirectory

### Adding a Note

1. Create `.ly` file in `src/note-reading/{treble|bass}/`
2. Name after the note (e.g., `c4.ly` for middle C)
3. Use standard note reading template with the specific note
4. Run `./scripts/build.sh` to generate image

## File Naming Conventions

- Key signature files: Use lowercase with hyphens (e.g., `c-sharp-major.ly`, `a-flat-minor.ly`)
- Note reading files: Use note name + octave (e.g., `c4.ly`, `g5.ly`)
- Images automatically match source filename (e.g., `c-sharp-major.ly` → `c-sharp-major.png`)

## Music Theory Flashcards (Text-Based)

### Source Material

Lesson notes are stored in Obsidian at:
```
/Users/ana/Documents/Obsidian Vault/Learning/Piano/Lessons/
```

Each lesson file (e.g., `2025-09-04.md`) contains vocabulary tables, concept explanations, and practice notes.

### CSV Format

All flashcard CSVs use three columns:
```csv
Front,Back,Tags
"Question text with <b>bold</b> for key terms","Answer text","lesson::001 type::vocabulary topic::intervals"
```

- Use HTML `<b>` tags for emphasis (Anki renders these)
- Escape quotes by doubling them: `""example""`
- All cards import into a single "Music Theory" deck; tags enable filtered study

### Tagging Schema

Every card gets three tags:

| Tag Type | Values | Purpose |
|----------|--------|---------|
| `lesson::` | `001`, `002`, `003`, `004`, ... | Filter by lesson |
| `type::` | `vocabulary`, `concept` | Card type |
| `topic::` | See list below | Subject area |

**Topic tags:**
- `basics` - sharps, flats, enharmonic
- `intervals` - half steps, interval names, qualities, inversions
- `scales` - patterns, scale types, degrees
- `triads` - formulas, chord types
- `keys` - relative/parallel keys, key signatures, circle of fifths
- `expression` - consonance, dissonance, modulation
- `motion` - parallel, contrary, oblique
- `acoustics` - frequency ratios
- `notation` - clef reading, mnemonics
- `history` - periods, composers, terms

### Card Creation Conventions

**Vocabulary terms** (from lesson vocabulary tables):
- Create TWO separate cards per term:
  1. Term → Definition: `"What is a <b>sharp</b>?"` → `"A symbol that raises a note by one half step"`
  2. Definition → Term: `"Which symbol raises a note by one half step?"` → `"A sharp (♯)"`
- Tag with `type::vocabulary`

**Concept cards** (from lesson content):
- Single-sided cards testing understanding
- Examples: scale patterns, interval half-step counts, triad formulas, historical facts
- Tag with `type::concept`

### File Naming

```
csv/music-theory-lesson-001.csv
csv/music-theory-lesson-002.csv
...
```

### Importing to Anki

1. File → Import → select CSV
2. Choose/create "Music Theory" deck (or appropriate sub-deck)
3. Map: Field 1 = Front, Field 2 = Back, Field 3 = Tags
4. Note type: "Basic" (single-sided cards)
5. Imports are additive—new cards add to existing deck

### Anki Deck Structure

The "Music Theory" deck uses sub-decks for organization:

```
Music Theory/
├── Lessons/
│   ├── Lesson_001    # Music Theory Foundations
│   ├── Lesson_002    # Intervals, Acoustics & Reading
│   ├── Lesson_003    # Minor Scale Types & Voice Motion
│   └── Lesson_004    # Music History Overview
└── Mnemonics         # Memory aids for keys, clefs, etc.
```

When importing CSVs, select the appropriate sub-deck (e.g., `Music Theory::Lessons::Lesson_001`).

### Mnemonics Deck

The `csv/mnemonics.csv` file uses a simplified tagging schema:
- `type::mnemonic` (instead of vocabulary/concept)
- `topic::keys` or `topic::notation`
- No `lesson::` tag (mnemonics span all lessons)

### Exporting the Combined Deck

Always export from the parent "Music Theory" deck to create a single `.apkg` package:

1. Right-click "Music Theory" deck in Anki
2. Select **Export**
3. Choose "Anki Deck Package (.apkg)"
4. Uncheck "Include scheduling information" (for sharing)
5. Save as `Music Theory.apkg` in the base directory

This preserves the sub-deck hierarchy and all tags. Do NOT export sub-decks individually.

### Filtered Study Sessions

Users can create filtered decks using tag queries:

| To study... | Search query |
|-------------|--------------|
| All mnemonics | `tag:type::mnemonic` |
| Lesson 1 only | `tag:lesson::001` |
| All intervals | `tag:topic::intervals` |
| Vocabulary only | `tag:type::vocabulary` |
