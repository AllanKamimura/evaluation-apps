#!/bin/bash

set -e

if [ -z "$1" ]; then
  echo "Usage: $0 <folder>"
  exit 1
fi

FOLDER="$1/tests"
OUT_DIR="$1"

# Loop over all .yml files in the folder
find "$FOLDER" -type f -name "*.yml" | while read -r file; do
  echo "Processing $file"

  # Get filename without path
  filename=$(basename "$file")

  # Remove ".test" before ".yml"
  clean_name="${filename/.test.yml/.yml}"

  out_file="$OUT_DIR/$clean_name"

  # Remove the ${WESTON_DEBUG} part and save to output
  sed -E 's/ ?\$\{WESTON_DEBUG\}//g' "$file" > "$out_file"
done

echo "Done. Output saved in $OUT_DIR"