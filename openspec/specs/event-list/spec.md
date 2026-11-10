# event-list Specification

## Purpose

Defines how the events screen shows whether each event is still open, and how it presents the actions for closing or reopening an event's account.

## Requirements

### Requirement: Open events are highlighted
On the events screen, the tile of an event that is not closed SHALL have a shadow in the app's accent (orange) color. The tile of a closed event SHALL keep the default neutral shadow.

#### Scenario: Open event tile
- **WHEN** the events list shows an event that has not been closed
- **THEN** its tile has an orange shadow

#### Scenario: Closed event tile
- **WHEN** the events list shows a closed event
- **THEN** its tile has the default neutral shadow

#### Scenario: Highlight updates after closing
- **WHEN** a user closes an open event from the events screen
- **THEN** that event's tile switches from the orange shadow to the neutral shadow

### Requirement: Close account is a primary action
The "Close account" button shown for an open event SHALL be a filled button with the accent (orange) background and dark text. Tapping it SHALL open the close-event form as before.

#### Scenario: Close button style
- **WHEN** a user expands an open event's tile
- **THEN** the "Close account" button is shown filled in orange with dark text

#### Scenario: Close button behavior unchanged
- **WHEN** the user taps "Close account"
- **THEN** the close-event form opens

### Requirement: Reopen account is a secondary action
The "Reopen account" button shown for a closed event SHALL be an outlined button with an accent (orange) border and orange text on the surface background. Tapping it SHALL open the reopen-event confirmation as before.

#### Scenario: Reopen button style
- **WHEN** a user expands a closed event's tile
- **THEN** the "Reopen account" button is shown with an orange outline and orange text

#### Scenario: Reopen button behavior unchanged
- **WHEN** the user taps "Reopen account"
- **THEN** the reopen-event confirmation opens
