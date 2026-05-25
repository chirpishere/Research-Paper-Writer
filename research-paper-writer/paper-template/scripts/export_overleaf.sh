#!/bin/bash
set -e

STAMP=$(date +%Y%m%d_%H%M%S)
ZIP="overleaf_${STAMP}.zip"

echo "Syncing LaTeX from markdown..."
bash scripts/md_to_tex.sh

echo ""
echo "Packaging..."
if [ -d "figures" ] && [ "$(ls -A figures 2>/dev/null)" ]; then
  zip -r "$ZIP" main.tex sections/ figures/
else
  zip -r "$ZIP" main.tex sections/
fi

echo ""
echo "Exported: $ZIP"
echo ""
echo "Upload to Overleaf:"
echo "  https://www.overleaf.com → New Project → Upload Project → select $ZIP"
