# Tasks

## 1. Tile shadow

- [x] 1.1 Add optional `shadowColor` to `AppTileInRow` (design D1), used as `shadowColor ?? colorScheme.outlineVariant`. Verify with a widget test `test/core/widgets/app_tile_in_row_test.dart` showing the tile's box shadow uses the given color, and `outlineVariant` when none is given.
- [x] 1.2 In `events_screen.dart`, pass `shadowColor: currentEvent.isClosed ? null : context.colorScheme.primary`. Verify in the app that open events have an orange shadow, closed events a neutral one, and that closing an event switches its shadow.

## 2. Account buttons

- [x] 2.1 Replace the "Close account" `AppElevatedButton` with a themed `ElevatedButton` and the "Reopen account" one with an `OutlinedButton` styled per design D2, keeping the same `onPressed` handlers and texts. Verify in the app that "Close account" is orange-filled with dark text, "Reopen account" is orange-outlined, and both still open their modals.

## 3. Checks

- [x] 3.1 Run `flutter analyze` (no new issues) and `flutter test`, including `flutter test test/goldens`. The goldens should not change, since the tile's default shadow is untouched. The only expected failure is the existing template `test/widget_test.dart`.
- [x] 3.2 Run `graphify update .` after the code changes.

## Workflow follow-up

- Archive this change once implementation is reviewed.
