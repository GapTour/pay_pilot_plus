# Tasks

## 1. Script

- [x] 1.1 Rework `scripts/update_versions.sh` per design D1–D3, replacing the one-platform-per-run version now in the working tree. It takes no argument, validates `jq`, the name and all three codes before any write, then writes:
  - `pubspec.yaml` `version: NAME+ANDROID`
  - `AppSettings.version`
  - `versionCode = ANDROID`
  - iOS and macOS `CFBundleVersion`

  Keep it executable in git. Verify by running it from the project root: `git diff` shows exactly those five files with 1.1.0+2 / '1.1.0' / 2 / 1 / 2, and the name placeholders are untouched. Then run it again from `scripts/` and confirm `git diff` is unchanged.
- [x] 1.2 Verify the error paths each exit non-zero and leave the five files unchanged:
  - a temporary config with `.version.ios.code = "abc"`
  - a temporary config with `.version.name = "1.1"`
  - the config temporarily renamed away

  Restore the config afterwards.

## 2. CI and docs

- [x] 2.1 Revert the "Apply macOS version" and "Apply Android version" steps in `.github/workflows/app_release.yaml` (design D4). Verify `git diff main -- .github/workflows/app_release.yaml` is empty. Keep `version_config.json` tracked (it's already staged).
- [x] 2.2 Update the three `update_versions.sh` lines in `CLAUDE.md` to the no-argument usage: edit `version_config.json`, run `./scripts/update_versions.sh`, commit the result. Verify with `grep update_versions CLAUDE.md`.

## 3. Checks

- [x] 3.1 Run `bash -n scripts/update_versions.sh` and `plutil -lint` on both `Info.plist` files. Run `flutter build macos --debug` and confirm the built app's `CFBundleVersion` (`/usr/libexec/PlistBuddy -c "Print :CFBundleVersion"` on the built `Info.plist`) is the macOS code and its `CFBundleShortVersionString` is the name.
- [x] 3.2 Run `graphify update .` after the changes.

## Workflow follow-up

- Commit the applied versions (the five files written by the script) together with `version_config.json`.
- Archive this change once implementation is reviewed.
