#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
cd "$SCRIPT_DIR"

TEMPLATE_REPO="git@github.com:XXCC-Unicorn-Press/journal-template.git"

# Add the remote template repository if it doesn't exist
git remote get-url template > /dev/null 2>&1 || git remote add template "$TEMPLATE_REPO"

# Fetch the latest changes from the template repository
echo "Fetching latest changes from the template repository..."
git fetch template

# Merge the latest changes from the template repository into the current branch
echo "Merging latest changes from the template repository..."
git merge template/main --allow-unrelated-histories --no-commit

# Reset protected files to their original state
echo "Resetting protected files to their original state..."
git checkout HEAD -- references.bib
git checkout HEAD -- preamble/meta.tex
git checkout HEAD -- preamble/custom.tex
git checkout HEAD -- content/
git checkout HEAD -- figures/
