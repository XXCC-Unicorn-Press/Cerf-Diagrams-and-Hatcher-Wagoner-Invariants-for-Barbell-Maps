#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
cd "$SCRIPT_DIR"

# Ensure the target directory exists
TARGET_DIR="target"
mkdir -p "$TARGET_DIR"

# Export Inkscape figures
./inkscape/export.sh
cp inkscape/logo.png "$TARGET_DIR/logo.png"
cp inkscape/frontcover.png "$TARGET_DIR/frontcover.png"
cp inkscape/backcover.png "$TARGET_DIR/backcover.png"

# LaTeX document name
TARGET_NAME="Cerf_Diagrams_and_Hatcher-Wagoner_Invariants_for_Barbell_Maps"
PRINT_VERSION_PDF="${TARGET_NAME}_Printed.pdf"
ONLINE_VERSION_PDF="${TARGET_NAME}_Online.pdf"

# Compile the LaTeX document (print version)
LATEX_VERSION="PRINT" latexmk
cp main.pdf "$TARGET_DIR/$PRINT_VERSION_PDF"

# Compile the LaTeX document (online version)
LATEX_VERSION="ONLINE" latexmk
cp main.pdf "$TARGET_DIR/$ONLINE_VERSION_PDF"
