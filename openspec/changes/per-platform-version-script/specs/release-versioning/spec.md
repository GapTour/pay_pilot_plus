# Spec Delta

## Purpose

Defines how the app's version name and per-platform build numbers are kept in one config file and written into the codebase for Android, iOS, and macOS, so each release commit carries its own versions.

## ADDED Requirements

### Requirement: Single version source
The project SHALL keep the version name and one build number each for Android, iOS, and macOS in `version_config.json` at the project root, under `.version.name`, `.version.android.code`, `.version.ios.code`, and `.version.macos.code`.

#### Scenario: Config shape
- **WHEN** the version is bumped to 1.2.0 with Android build 5
- **THEN** `version_config.json` holds `"name": "1.2.0"` and `"android": { "code": 5 }`

### Requirement: One run updates the codebase
Running `scripts/update_versions.sh` SHALL write the configured versions into the codebase:
- `pubspec.yaml` `version: <name>+<android code>`
- `AppSettings.version = '<name>'`
- Android `versionCode = <android code>` in `android/app/build.gradle.kts`
- `CFBundleVersion` = `<ios code>` in `ios/Runner/Info.plist`
- `CFBundleVersion` = `<macos code>` in `macos/Runner/Info.plist`

#### Scenario: All platforms from one run
- **WHEN** the config has name 1.1.0 and codes android 2, ios 1, macos 2, and the script runs
- **THEN** `pubspec.yaml` has `version: 1.1.0+2`, `AppSettings.version` is `'1.1.0'`, `versionCode = 2`, the iOS `CFBundleVersion` is `1`, and the macOS `CFBundleVersion` is `2`

#### Scenario: Running twice is stable
- **WHEN** the script runs a second time with the same config
- **THEN** no file changes

### Requirement: Version name follows pubspec
The script SHALL NOT write the version name into the native files. `versionName` SHALL stay `flutter.versionName`, and both `CFBundleShortVersionString` values SHALL stay `$(FLUTTER_BUILD_NAME)`.

#### Scenario: Name placeholders preserved
- **WHEN** the script runs
- **THEN** `versionName = flutter.versionName` and `CFBundleShortVersionString` = `$(FLUTTER_BUILD_NAME)` are unchanged

### Requirement: Runs from any directory
The script SHALL resolve all files relative to the project root, regardless of the current working directory.

#### Scenario: Run from the project root
- **WHEN** a user runs `./scripts/update_versions.sh` from the project root
- **THEN** the project's files are updated

#### Scenario: Run from inside scripts
- **WHEN** a user runs `./update_versions.sh` from `scripts/`
- **THEN** the same files are updated

### Requirement: Invalid input fails without writing
The script SHALL exit non-zero, print the reason, and change no files when: `jq` is unavailable; `version_config.json` is missing; the name is not `MAJOR.MINOR.PATCH`; or any of the three platform codes is not a positive integer.

#### Scenario: One bad code blocks all writes
- **WHEN** `.version.ios.code` is `"abc"` and the Android and macOS codes are valid
- **THEN** the script exits non-zero, names `.version.ios.code`, and changes no files

### Requirement: Committed versions drive release builds
The release workflow SHALL NOT run the version script. It SHALL build the versions committed in the codebase.

#### Scenario: CI builds committed versions
- **WHEN** a commit with `versionCode = 2` and macOS `CFBundleVersion` `2` is tagged for release
- **THEN** the APK has versionCode 2 and the macOS app has build number 2, with no version step in the workflow
