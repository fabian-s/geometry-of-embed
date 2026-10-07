#!/usr/bin/env bash
# Build the seminar website from the .qmd sources in the parent (seminar) repo.
# This repo lives there as the `website/` submodule; output goes to docs/.
set -euo pipefail
cd "$(dirname "$0")"

# copy a source file, dropping the `format:` block (PDF settings) from its YAML header
copy() {
  awk 'NR == 1 { print; yaml = 1; next }
       yaml && /^---$/ { yaml = 0 }
       yaml && /^format:/ { skip = 1; next }
       skip && /^[[:space:]]/ { next }
       { skip = 0; print }' "$1" > "$2"
}

copy ../representation-learning-announcement.qmd index.qmd
copy ../representation-learning-schedule.qmd schedule.qmd
copy ../course-materials/representation-comparison-primer.qmd primer.qmd
copy ../course-materials/concept-glossary.qmd glossary.qmd

quarto render
touch docs/.nojekyll
