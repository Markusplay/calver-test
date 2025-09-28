#!/bin/bash

# Test script for CalVer tagging logic
# This script simulates the CalVer tag generation without actually creating tags

echo "=== CalVer Tagging Test Script ==="
echo "Testing the CalVer tag generation logic..."
echo

# Get current date and time in UTC (same as workflow)
CURRENT_DATE=$(date -u '+%Y.%m.%d')
CURRENT_TIME=$(date -u '+%H-%M')  # Use hyphen instead of colon for git compatibility

echo "Current UTC date: $CURRENT_DATE"
echo "Current UTC time: $CURRENT_TIME"
echo

# Check for existing tags for today
echo "Searching for existing tags with pattern: ${CURRENT_DATE}_*"
TODAY_TAGS=$(git tag -l "${CURRENT_DATE}_*" 2>/dev/null | sort -V)

if [ ! -z "$TODAY_TAGS" ]; then
  echo "Found existing tags for today:"
  echo "$TODAY_TAGS"
  echo
  
  LAST_TAG=$(echo "$TODAY_TAGS" | tail -n 1)
  echo "Last tag for today: $LAST_TAG"
  
  # Extract the auto increment from the last tag
  AUTO_INCREMENT=$(echo "$LAST_TAG" | sed -n 's/.*\.\([0-9]*\)$/\1/p')
  
  if [ -z "$AUTO_INCREMENT" ] || [ "$AUTO_INCREMENT" = "" ]; then
    AUTO_INCREMENT=0
  fi
  
  AUTO_INCREMENT=$((AUTO_INCREMENT + 1))
  echo "Next auto_increment would be: $AUTO_INCREMENT"
else
  echo "No existing tags found for today"
  AUTO_INCREMENT=0
  echo "Starting with auto_increment: $AUTO_INCREMENT"
fi

echo

# Generate what the CalVer tag would be (using underscore instead of colon for git compatibility)
CALVER_TAG="${CURRENT_DATE}_${CURRENT_TIME}.${AUTO_INCREMENT}"
echo "Would generate CalVer tag: $CALVER_TAG"

# Check if this tag would conflict
if git rev-parse "$CALVER_TAG" >/dev/null 2>&1; then
  echo "WARNING: Tag $CALVER_TAG already exists!"
else
  echo "Tag $CALVER_TAG is available"
fi

echo
echo "=== Test completed ==="