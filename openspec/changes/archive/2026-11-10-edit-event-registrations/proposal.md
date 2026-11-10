# Proposal

## Why

On the event details screen, a registration can only be deleted, not corrected. Fixing a typo in an amount or a wrong bank means deleting and re-registering, which renumbers journals and loses the original series. Tiles also hide the other side of each posting (which bank received the money, which staff member collected it), so operators cannot check settlements at a glance.

## What Changes

- Add an edit action to each registration tile on the registrations tab, available only while the event is open.
- Editing opens the same form used to register (guest or staff), prefilled with the registration's current values. Every field is editable except the person.
- Saving an edit rewrites the registration's journal lines **in place**: the lines of the registration series and payment series are replaced inside their existing journal headers, keeping the same series and entry numbers. Other guests' lines in a shared header are untouched.
- The registration row and its journal lines are updated in one transaction; a failure leaves both unchanged.
- Edits that add or remove a payment (net amount becomes greater than zero, or drops to zero) post a new payment journal or remove the existing one.
- Registration tiles show the counterparty: the bank a guest's payment was deposited to, the staff member who collected it, the staff member or fund charged for a free guest's snacks, or "charged to own account" for staff. Tiles also show gross and discount when a discount was given.

## Capabilities

### New Capabilities
- `event-registration`: Editing an existing event registration together with its journals, and showing each registration's settlement counterparty on the registrations tab.

### Modified Capabilities
_None. No specs are archived yet. The draft baseline in `document-baseline-capabilities` does not cover registrations._

## Impact

- **UI**: `features/event_details/presentation/screens/tabs/registrations_tab_view.dart` (edit action, richer tile), `attend_guest_modal_view.dart` and `attend_member_modal_view.dart` (edit mode with a locked person field), `EventRegistrationsCubit` (new update action).
- **Data**: `EventRegistrationsLocalProvider` and `IEventRegistrationsSource` (new update operation, counterparty lookup), `EventRegistrationsDao` (update row), `JournalsDao` (replace one series' lines within its header), the registration and payment journal helpers (accept an existing series).
- **Models**: `EventRegistrationModel` gains settlement-counterparty and snacks-assignment fields.
- **Localization**: new strings for the tile counterparty labels and the edit modal title (fa and en ARB files).
- **Schema**: no database migration. The counterparty is derived from existing journal lines.
- **Journal dates**: when an edit changes the date and the header is shared with other guests, the header keeps its date and only the edited lines take the new date. This differs from the draft baseline rule "a journal's entry date applies to all lines", which should be reworded to apply at posting time before that baseline is archived.
