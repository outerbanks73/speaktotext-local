# SpeakToText Local - Safari Extension

This directory contains the Safari Web Extension version of SpeakToText Local.

## Overview

Safari Web Extensions use the same WebExtension APIs as Chrome, so we share the core JavaScript code between both browsers. The Safari extension requires an Xcode project wrapper to build and sign.

## Building the Safari Extension

### Prerequisites

- macOS 11.0 (Big Sur) or later
- Xcode 12.0 or later
- Apple Developer account (free account works for personal use)

### Build Steps

#### Option 1: Using the Conversion Tool (Recommended)

Apple provides a tool to convert Chrome extensions to Safari:

```bash
# Navigate to the project root
cd speaktotext-local

# Run the Safari Web Extension converter
xcrun safari-web-extension-converter extension/ --project-location safari-extension/ --app-name "SpeakToText Local"
```

This will:
1. Create an Xcode project in the `safari-extension/` directory
2. Copy the extension files
3. Generate the necessary Swift wrapper code

#### Option 2: Manual Setup

1. Open Xcode
2. Create a new project: File → New → Project
3. Select "Safari Extension App" template
4. Copy the contents of `extension/` to the Resources folder
5. Update the `manifest.json` for Safari compatibility

### Safari-Specific Manifest Changes

The `manifest.json` needs minor adjustments for Safari. Create `manifest-safari.json`:

```json
{
  "manifest_version": 3,
  "name": "SpeakToText Local",
  "version": "1.3.0",
  "description": "Transcribe audio locally with speaker identification.",
  "permissions": [
    "storage",
    "activeTab"
  ],
  "host_permissions": [
    "http://localhost:5123/*"
  ],
  "action": {
    "default_popup": "popup.html",
    "default_icon": {
      "16": "icons/icon16.png",
      "32": "icons/icon32.png",
      "48": "icons/icon48.png",
      "128": "icons/icon128.png"
    }
  },
  "options_page": "options.html",
  "background": {
    "service_worker": "background.js"
  },
  "icons": {
    "16": "icons/icon16.png",
    "32": "icons/icon32.png",
    "48": "icons/icon48.png",
    "128": "icons/icon128.png"
  }
}
```

**Note:** Safari doesn't support `tabCapture` API, so tab recording is Chrome-only.

### Running the Extension

1. Open the generated Xcode project
2. Select your development team in Signing & Capabilities
3. Build and run (⌘R)
4. Enable the extension in Safari:
   - Safari → Preferences → Extensions
   - Check "SpeakToText Local"

### Differences from Chrome Version

| Feature | Chrome | Safari |
|---------|--------|--------|
| File Upload | ✅ | ✅ |
| URL Transcription | ✅ | ✅ |
| Tab Recording | ✅ | ❌ (API not available) |
| Speaker Diarization | ✅ | ✅ |
| Real-time Mode | ✅ | ❌ (requires tab capture) |

### Troubleshooting

**"Extension not loading"**
- Make sure "Allow Unsigned Extensions" is enabled in Safari's Develop menu
- Re-run the app from Xcode

**"Cannot connect to server"**
- Ensure the Python server is running on localhost:5123
- Safari may block localhost connections - check Safari's privacy settings

**"Extension crashes"**
- Check the Web Inspector console (Develop → Web Extension Background Page)
- Verify all file paths are correct in the Xcode project

## Distribution

### For Personal Use
- Build and run from Xcode with your Apple ID

### For Public Distribution
- Requires Apple Developer Program membership ($99/year)
- Submit to App Store through App Store Connect
- Apple reviews the extension before publishing
