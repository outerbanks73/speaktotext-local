#!/bin/bash

# SpeakToText Local - Safari Extension Builder
# Converts the Chrome extension to a Safari Web Extension

set -e

echo "========================================"
echo "  SpeakToText Local - Safari Builder"
echo "========================================"
echo

# Get the directory where this script is located
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cd "$SCRIPT_DIR"

# Check if Xcode is installed
if ! command -v xcrun &> /dev/null; then
    echo "Error: Xcode command line tools not found."
    echo "Please install Xcode from the App Store."
    exit 1
fi

# Check if safari-web-extension-converter exists
if ! xcrun --find safari-web-extension-converter &> /dev/null; then
    echo "Error: safari-web-extension-converter not found."
    echo "Please install Xcode 12.0 or later."
    exit 1
fi

# Create a temporary directory for Safari-compatible extension
TEMP_DIR=$(mktemp -d)
echo "Creating Safari-compatible extension..."

# Copy extension files
cp -r extension/* "$TEMP_DIR/"

# Replace manifest with Safari version
cp safari-extension/manifest.json "$TEMP_DIR/manifest.json"

# Create Safari-specific popup that hides tab recording
cat > "$TEMP_DIR/popup-safari.js" << 'EOFJS'
// Safari-specific overrides
// Hide tab recording since Safari doesn't support tabCapture API

document.addEventListener('DOMContentLoaded', () => {
  // Hide the Record tab since Safari doesn't support tabCapture
  const recordTab = document.querySelector('[data-tab="record"]');
  if (recordTab) {
    recordTab.style.display = 'none';
  }

  // Hide the record tab content
  const recordContent = document.getElementById('tab-record');
  if (recordContent) {
    recordContent.remove();
  }

  // Make URL tab the only visible option besides File
  const tabs = document.querySelectorAll('.tab');
  tabs.forEach(tab => {
    if (tab.dataset.tab === 'record') {
      tab.style.display = 'none';
    }
  });
});
EOFJS

# Append Safari overrides to popup.js
cat "$TEMP_DIR/popup-safari.js" >> "$TEMP_DIR/popup.js"
rm "$TEMP_DIR/popup-safari.js"

# Check if Xcode project already exists
if [ -d "safari-extension/SpeakToText Local" ]; then
    echo "Existing Safari project found. Updating resources..."

    # Update the Resources folder
    RESOURCES_DIR="safari-extension/SpeakToText Local/SpeakToText Local Extension/Resources"
    if [ -d "$RESOURCES_DIR" ]; then
        rm -rf "$RESOURCES_DIR"/*
        cp -r "$TEMP_DIR"/* "$RESOURCES_DIR/"
        echo "✅ Resources updated!"
    else
        echo "Warning: Resources directory not found at expected location."
        echo "You may need to manually update the extension files in Xcode."
    fi
else
    echo "Creating new Safari Web Extension project..."
    echo

    # Run the converter
    xcrun safari-web-extension-converter "$TEMP_DIR" \
        --project-location safari-extension/ \
        --app-name "SpeakToText Local" \
        --bundle-identifier com.speaktotext.local \
        --swift \
        --force \
        --no-open

    echo
    echo "✅ Safari extension project created!"
fi

# Cleanup
rm -rf "$TEMP_DIR"

echo
echo "========================================"
echo "  Build Complete!"
echo "========================================"
echo
echo "Next steps:"
echo "1. Open: safari-extension/SpeakToText Local/SpeakToText Local.xcodeproj"
echo "2. Select your Development Team in Signing & Capabilities"
echo "3. Build and Run (⌘R)"
echo "4. Enable extension in Safari → Preferences → Extensions"
echo
echo "Note: Tab recording is not available in Safari (API limitation)."
echo
