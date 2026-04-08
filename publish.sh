#!/bin/bash

# Stop on first error
set -e

# Ensure we're in the workspace root
# If you run this script outside of the root, you might want to adjust the path.
WORKSPACE_ROOT=$(pwd)
PACKAGES_DIR="$WORKSPACE_ROOT/packages"

echo "Checking for uncommitted git changes..."
if [ -n "$(git status --porcelain)" ]; then
  echo "Error: You have uncommitted git changes."
  echo "Please commit your changes before publishing packages to ensure a clean state."
  echo "Modified files:"
  git status -s
  exit 1
fi

echo "All clean! Starting publication process..."

for dir in "$PACKAGES_DIR"/*/; do
  if [ -f "${dir}pubspec.yaml" ]; then
    PACKAGE_NAME=$(basename "$dir")
    echo "=========================================================="
    echo "📦 Publishing package: $PACKAGE_NAME"
    echo "=========================================================="
    
    cd "$dir"
    
    # Let pub get ensure dependencies are perfectly resolved
    dart pub get
    
    # Run publish!
    # NOTE: Since publishing requires your explicit terminal confirmation (y/N) 
    # and possibly browser authentication, the script will naturally pause here 
    # waiting for you to complete the auth for each package.
    dart pub publish
    
    cd "$WORKSPACE_ROOT"
    echo "✅ Finished processing $PACKAGE_NAME."
    echo ""
  fi
done

echo "🎉 All packages have been successfully published!"
