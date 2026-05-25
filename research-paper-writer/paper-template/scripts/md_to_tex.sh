#!/bin/bash
set -e

mkdir -p sections

for file in sections_md/*.md; do
  [ -f "$file" ] || continue
  filename=$(basename "$file" .md)
  pandoc "$file" \
    --from=markdown \
    --to=latex \
    --wrap=none \
    --top-level-division=section \
    -o "sections/${filename}.tex"
  echo "Converted: sections/${filename}.tex"
done

echo ""
echo "Done. Run: pdflatex main.tex"
