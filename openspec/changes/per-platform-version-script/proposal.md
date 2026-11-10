# Proposal

## Why

`version_config.json` holds the app version name and a separate build number per platform (Android, iOS, macOS), but `scripts/update_versions.sh` does not apply it correctly:

- It hard-codes the version **name** into the native files, which disconnects them from `pubspec.yaml`.
- It writes `pubspec.yaml` without a build number, so Flutter currently generates the invalid build number `1.0.0`.
- It gives macOS the iOS build number.
- It only works when run from inside `scripts/`, although the documented usage runs it from the project root.

The versions need to live **in the codebase**. One local run should update every file, so the result can be reviewed and committed, and CI then builds exactly what was committed.

## What Changes

- One run, with no argument: `./scripts/update_versions.sh` applies `version_config.json` to every file:
  - `pubspec.yaml`: `version: <name>+<android code>`
  - `AppSettings.version`: `'<name>'`
  - `android/app/build.gradle.kts`: `versionCode = <android code>`
  - `ios/Runner/Info.plist`: `CFBundleVersion` = `<ios code>`
  - `macos/Runner/Info.plist`: `CFBundleVersion` = `<macos code>`
- The version **name** stays on Flutter's placeholders in the native files (`flutter.versionName`, `$(FLUTTER_BUILD_NAME)`), so it always follows `pubspec.yaml`.
- macOS uses `.version.macos.code`.
- The script works from any directory, validates the whole config before writing anything, and fails on any error.
- CI runs no version step. The release workflow builds the committed versions.
- `version_config.json` is committed as the single source of truth.

## Capabilities

### New Capabilities
- `release-versioning`: How the app's version name and per-platform build numbers flow from `version_config.json` into the committed codebase.

### Modified Capabilities
_None._

## Impact

- `scripts/update_versions.sh`: rewritten. Needs `jq`; it runs locally, never in CI.
- Written by the script: `pubspec.yaml`, `lib/core/utils/constants/app_settings.dart`, `android/app/build.gradle.kts`, `ios/Runner/Info.plist`, `macos/Runner/Info.plist`.
- `version_config.json`: committed. Format unchanged.
- `.github/workflows/app_release.yaml`: unchanged from `main`.
- `CLAUDE.md`: usage lines updated.
- `flutter build --build-number` no longer changes the Android, iOS, or macOS build number. The committed values win.
