#!/bin/bash

# File names
NAVIGATION="navigation.json"
FINAL="final.json"
TEMP="temp.json"

# Check if navigation.json exists
if [[ ! -f "$NAVIGATION" ]]; then
  echo "Error: $NAVIGATION not found!"
  exit 1
fi

# Extract the target object from navigation.json
EXTRACTED=$(jq '[.moreMenu.items[] | select(.type == "PARENT" and .label == "emp_common_more_menu_external_links")]' "$NAVIGATION")

# If final.json doesn't exist, create an empty array
if [[ ! -f "$FINAL" ]]; then
  echo "[]" > "$FINAL"
fi

# Append the extracted object(s) to final.json
jq --argjson new "$EXTRACTED" '. + $new' "$FINAL" > "$TEMP" && mv "$TEMP" "$FINAL"

echo "Object successfully copied from $NAVIGATION to $FINAL"
