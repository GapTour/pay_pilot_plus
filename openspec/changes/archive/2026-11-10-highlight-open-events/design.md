# Design

## Context

See proposal.md for motivation and specs/event-list/spec.md for required behavior.

- Event tiles use `AppTileInRow`. Its shadow is hard-coded to `colorScheme.outlineVariant`. The sibling widget `AppTile` already has an optional `shadowColor` for the same purpose; the registrations tab uses it to flag pending guests.
- The accent orange (`#F7941D`) is `colorScheme.primary`.
- The close/reopen buttons are `AppElevatedButton`, the app's neumorphic "clay" button. It always paints `colorScheme.surface` and has no color parameter.
- The app theme already defines `elevatedButtonTheme` as accent background, `onAccent` text, 48px minimum height, and 12px radius. That is exactly the requested "orange filled" style.

## Goals / Non-Goals

**Goals:**
- Highlight open event tiles and restyle the two account buttons, without affecting the other screens that use `AppTileInRow` or `AppElevatedButton`.

**Non-Goals:**
- Restyling `AppElevatedButton` globally or the tile's Preview/edit buttons.
- Changing close/reopen behavior or texts.

## Decisions

### D1. Add `shadowColor` to `AppTileInRow`
Add `final Color? shadowColor`, used as `shadowColor ?? colorScheme.outlineVariant`. This mirrors `AppTile`, so both tiles share one API, and existing callers don't change. The events screen passes `currentEvent.isClosed ? null : context.colorScheme.primary`.

- *Alternative*: wrap the tile in another `DecoratedBox`. This produces a doubled shadow and duplicates the radius.

### D2. Use Flutter's built-in buttons, not `AppElevatedButton`
- **Close account**: a plain `ElevatedButton`. The theme already makes it orange-filled with dark text, so no per-widget style is needed.
- **Reopen account**: an `OutlinedButton` with a local `OutlinedButton.styleFrom(foregroundColor: colorScheme.primary, side: BorderSide(color: colorScheme.primary, width: 1.5), shape: same 12px radius)`. The theme has no `outlinedButtonTheme`, and one call site doesn't justify adding one.

Corner radius is 12px, from the theme, rather than the clay button's 15px. This keeps it consistent with every other `ElevatedButton` in the app. If 15px is wanted, it's a one-line override.

- *Alternative*: add a color/variant parameter to `AppElevatedButton`. The clay package's depth shading on an orange fill looks muddy, and it would add an option that only one screen uses.

## Risks / Trade-offs

- [The buttons no longer match the clay look of the Preview button in the same tile] → This is intended: the account action should stand out. If it looks off, switching to the clay variant later only touches `events_screen.dart`.
- [The golden gallery (`test/goldens/`) renders `AppTileInRow`] → The default shadow is unchanged, so the goldens should not change. The tasks re-run them to confirm.

## Migration Plan

UI only; no data changes. To roll back, revert the code.
