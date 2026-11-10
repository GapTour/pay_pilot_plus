# Proposal

## Why

On the events screen, open and closed events look the same until a tile is expanded, so operators cannot see at a glance which events still need closing. The close/reopen buttons also share one neutral style, so the main action on an open event ("Close account") does not stand out.

## What Changes

- Event tiles for open events get an orange (accent) shadow. Closed events keep the current neutral shadow.
- The "Close account" button on open events becomes an orange filled button (accent background, dark text).
- The "Reopen account" button on closed events becomes an orange outlined button (surface background, orange border and text).
- No change to what the buttons do. They open the same close or reopen modals.

## Capabilities

### New Capabilities
- `event-list`: How the events screen presents each event's open or closed state and its close/reopen actions.

### Modified Capabilities
_None._

## Impact

- `lib/features/events/presentation/screens/events_screen.dart`: tile shadow and both buttons.
- `lib/core/widgets/app_tile_in_row.dart`: new optional `shadowColor`, mirroring `AppTile`. The default is unchanged, so the other 24 screens using this tile are unaffected.
- No data, schema, localization, or dependency changes.
