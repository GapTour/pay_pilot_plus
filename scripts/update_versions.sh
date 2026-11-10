#!/bin/bash

# Writes the versions from version_config.json into the codebase.
#
# Usage: ./scripts/update_versions.sh
#
#   pubspec.yaml               version: <name>+<android code>
#   app_settings.dart          AppSettings.version = '<name>'
#   build.gradle.kts           versionCode = <android code>
#   ios/Runner/Info.plist      CFBundleVersion = <ios code>
#   macos/Runner/Info.plist    CFBundleVersion = <macos code>
#
# The version name stays on Flutter's placeholders in the native files
# (flutter.versionName, $(FLUTTER_BUILD_NAME)), so it follows pubspec.yaml.
# Commit the result; the release workflow builds what is committed.

set -euo pipefail

cd "$(dirname "$0")/.."

CONFIG=version_config.json
PUBSPEC=pubspec.yaml
APP_SETTINGS=lib/core/utils/constants/app_settings.dart
GRADLE=android/app/build.gradle.kts
IOS_PLIST=ios/Runner/Info.plist
MACOS_PLIST=macos/Runner/Info.plist

fail() {
    echo "Error: $1" >&2
    exit 1
}

command -v jq >/dev/null || fail "jq is required (brew install jq)"
[ -f "$CONFIG" ] || fail "$CONFIG not found in project root"

NAME=$(jq -r '.version.name // empty' "$CONFIG")
[[ "$NAME" =~ ^[0-9]+\.[0-9]+\.[0-9]+$ ]] ||
    fail ".version.name must be MAJOR.MINOR.PATCH, got '$NAME'"

code() {
    local value
    value=$(jq -r ".version.$1.code // empty" "$CONFIG")
    [[ "$value" =~ ^[1-9][0-9]*$ ]] ||
        fail ".version.$1.code must be a positive integer, got '$value'"
    echo "$value"
}

ANDROID_CODE=$(code android)
IOS_CODE=$(code ios)
MACOS_CODE=$(code macos)

# sed into a temp file: `sed -i` syntax differs between BSD and GNU sed
replace() {
    sed "$1" "$2" >"$2.tmp" && mv "$2.tmp" "$2"
}

replace "s/^version: .*/version: $NAME+$ANDROID_CODE/" "$PUBSPEC"
replace "s/static const String version = '[^']*';/static const String version = '$NAME';/" "$APP_SETTINGS"
replace "s/^\( *\)versionCode = .*/\1versionCode = $ANDROID_CODE/" "$GRADLE"
# Only the <string> line after the key; PlistBuddy would reorder the whole plist
bundle_version() {
    replace "/<key>CFBundleVersion<\/key>/{n;s|<string>[^<]*</string>|<string>$1</string>|;}" "$2"
}
bundle_version "$IOS_CODE" "$IOS_PLIST"
bundle_version "$MACOS_CODE" "$MACOS_PLIST"

echo "Applied version $NAME"
echo "  $PUBSPEC: version: $NAME+$ANDROID_CODE"
echo "  $APP_SETTINGS: version = '$NAME'"
echo "  $GRADLE: versionCode = $ANDROID_CODE"
echo "  $IOS_PLIST: CFBundleVersion = $IOS_CODE"
echo "  $MACOS_PLIST: CFBundleVersion = $MACOS_CODE"
echo "Commit these files before running the release workflow."
