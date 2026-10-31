#!/bin/bash

# Packages the macOS release build into a drag-to-install DMG:
# a window with the app and an Applications shortcut to drop it on.
# Usage: ./scripts/build_macos_dmg.sh   (run `flutter build macos --release` first)
# Prints only the path of the created DMG on stdout; logs go to stderr.

set -euo pipefail

if ! command -v create-dmg &> /dev/null; then
    echo "Error: create-dmg is required but not installed." >&2
    echo "You can install it with: brew install create-dmg" >&2
    exit 1
fi

RELEASE_DIR="build/macos/Build/Products/Release"
APP_PATH=$(find "$RELEASE_DIR" -maxdepth 1 -name "*.app" -type d | head -n 1)

if [ -z "$APP_PATH" ]; then
    echo "Error: no .app found in $RELEASE_DIR. Run: flutter build macos --release" >&2
    exit 1
fi

APP_NAME=$(basename "$APP_PATH" .app)
DMG_PATH="$RELEASE_DIR/$APP_NAME-macos.dmg"

# create-dmg copies the whole source folder, so stage only the app
STAGING=$(mktemp -d)
trap 'rm -rf "$STAGING"' EXIT
cp -R "$APP_PATH" "$STAGING/"
rm -f "$DMG_PATH"

# 600x400 window: app on the left, Applications on the right
create-dmg \
    --volname "$APP_NAME" \
    --window-size 600 400 \
    --icon-size 128 \
    --icon "$APP_NAME.app" 160 190 \
    --hide-extension "$APP_NAME.app" \
    --app-drop-link 440 190 \
    --no-internet-enable \
    "$DMG_PATH" \
    "$STAGING" >&2

echo "$DMG_PATH"
