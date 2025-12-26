#!/bin/bash

# Build script for music-theory-anki
# Compiles all LilyPond files to PNG images

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ROOT_DIR="$(dirname "$SCRIPT_DIR")"
SRC_DIR="$ROOT_DIR/src"
IMG_DIR="$ROOT_DIR/images"

RESOLUTION=400

echo "Building music theory images..."
echo "Resolution: ${RESOLUTION} dpi"
echo ""

# Function to compile key signature .ly files
compile_key_signatures() {
    local subdir=$1  # e.g., treble-major, bass-minor
    local src_path="$SRC_DIR/key-signatures/$subdir"
    local img_path="$IMG_DIR/key-signatures/$subdir"

    if [ ! -d "$src_path" ]; then
        echo "  Skipping $src_path (not found)"
        return
    fi

    local count=$(find "$src_path" -name "*.ly" 2>/dev/null | wc -l | tr -d ' ')
    if [ "$count" -eq 0 ]; then
        echo "  Skipping $src_path (no .ly files)"
        return
    fi

    mkdir -p "$img_path"
    echo "  Compiling $count files from $subdir"

    for ly_file in "$src_path"/*.ly; do
        if [ -f "$ly_file" ]; then
            filename=$(basename "$ly_file" .ly)
            lilypond --png -dresolution=$RESOLUTION -o "$img_path/$filename" "$ly_file" 2>/dev/null
            echo "    ✓ $filename"
        fi
    done
}

# Function to compile note reading files
compile_notes() {
    local deck=$1
    local src_path="$SRC_DIR/note-reading/$deck"
    local img_path="$IMG_DIR/note-reading/$deck"
    
    if [ ! -d "$src_path" ]; then
        echo "  Skipping $src_path (not found)"
        return
    fi
    
    local count=$(find "$src_path" -name "*.ly" 2>/dev/null | wc -l | tr -d ' ')
    if [ "$count" -eq 0 ]; then
        echo "  Skipping $src_path (no .ly files)"
        return
    fi
    
    mkdir -p "$img_path"
    echo "  Compiling $count files from $src_path"

    for ly_file in "$src_path"/*.ly; do
        if [ -f "$ly_file" ]; then
            filename=$(basename "$ly_file" .ly)
            lilypond --png -dresolution=$RESOLUTION -o "$img_path/$filename" "$ly_file" 2>/dev/null
            echo "    ✓ $filename"
        fi
    done
}

# Key signatures
echo "Key Signatures:"
compile_key_signatures treble-major
compile_key_signatures treble-minor
compile_key_signatures bass-major
compile_key_signatures bass-minor

echo ""

# Note reading
echo "Note Reading:"
compile_notes treble-beginner
compile_notes treble-intermediate
compile_notes treble-advanced
compile_notes bass-beginner
compile_notes bass-intermediate
compile_notes bass-advanced

echo ""
echo "Build complete!"
echo "Images saved to: $IMG_DIR"
