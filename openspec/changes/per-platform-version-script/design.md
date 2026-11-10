# Design

## Context

See proposal.md for motivation and specs/release-versioning/spec.md for required behavior.

- Flutter carries `pubspec.yaml` `version: NAME+N` into the native builds through placeholders: `flutter.versionName`/`flutter.versionCode` on Android, `$(FLUTTER_BUILD_NAME)`/`$(FLUTTER_BUILD_NUMBER)` in both `Info.plist` files. It has only **one** build number.
- The user needs every platform's build number committed in the codebase, so one local run has to produce all of them. CI then builds what was committed.
- A first implementation of this change (one platform per run, wired into CI) is in the working tree, uncommitted. This design replaces it.

## Goals / Non-Goals

**Goals:**
- One local run writes all versions into the codebase, ready to commit.
- The version name has a single source in the native builds: `pubspec.yaml`, through the placeholders.

**Non-Goals:**
- Running the script in CI.
- Bumping numbers automatically.
- Changing the JSON format.

## Decisions

### D1. Name via placeholders, build numbers written natively
Only the build-number fields get literal values:
- `versionCode = <android code>`, by `sed` on the anchored `versionCode = ` line. That line matches both `flutter.versionCode` and a previous literal, so reruns are safe.
- Each `Info.plist` `CFBundleVersion`, through a targeted `sed` that replaces only the `<string>` line after `<key>CFBundleVersion</key>`. `PlistBuddy` was tried first, but it rewrites the whole file and reordered unrelated keys in the iOS plist, which made every bump a noisy diff.

The name fields keep their placeholders, so the name only ever lives in `pubspec.yaml` (and `AppSettings`).

- *Alternative*: hard-code the name too. The user rejected this, and it would give the name four copies.
- *Alternative*: a build-time override (gradle reading the JSON, a custom xcconfig variable). It keeps placeholders everywhere, but the versions would not be visible in the committed native files, which is what the user asked for.

### D2. `pubspec.yaml` build number = Android code
`pubspec.yaml` needs some build number for `version:` to be valid. The Android code is the natural choice: it is the one Flutter would have used for the Android placeholder. It doesn't affect iOS or macOS, which have their own literals.

### D3. Fail-fast, root-relative script
- `set -euo pipefail` and `cd "$(dirname "$0")/.."`
- Validate before any write: `jq` exists, the config file is present, the name matches `^[0-9]+\.[0-9]+\.[0-9]+$`, and all three codes match `^[1-9][0-9]*$`
- Edit every file with one portable `sed`-to-temp-file-then-`mv` helper, which works with both BSD and GNU sed. The script runs locally only, but has no macOS-only dependency.

### D4. No CI version step
Revert the two "Apply ... version" steps added to `.github/workflows/app_release.yaml`; that file ends up identical to `main`. Commit `version_config.json` as the source of truth.

## Risks / Trade-offs

- [Someone edits `version_config.json` but forgets to run the script] → CI builds the old versions. The script prints every value it wrote, and its output belongs in the release checklist (CLAUDE.md).
- [`flutter build --build-number` is ignored for Android, iOS, and macOS] → Accepted: the committed values are the source of truth.
- [The plist `sed` assumes the value is on the line right after the key, which is how Xcode and Flutter write it] → Verify with `plutil -lint` after each run (task 3.1).

## Migration Plan

1. Run the script once and commit the result (1.1.0; android 2, ios 1, macos 2).
2. To roll back, revert the commit. The native build-number fields return to Flutter's placeholders.
