# Tasks

## 1. Journal layer

- [x] 1.1 Add an optional `String? series` parameter to `identificationGuestAttending`, `identificationStaffAttending`, `registerPaymentFromGuest`, and `fromGuestsToStaff`, used instead of a generated series when given (design D3). Verify that `flutter test` still passes for existing callers.
- [x] 1.2 Add `JournalsDao.replaceSeriesLines({series, lines, date})` per design D2: single-header check, balance check, replace lines in the same header, delete the header when it is left empty, and update the header date only when the header holds only this series. Verify with a new `test/core/database/replace_series_lines_test.dart` (in-memory DB, like `atomic_writes_test.dart`) covering: a shared header leaves the other series untouched, the entry number is unchanged, an unbalanced input throws and changes nothing, empty input removes the header, and header-date behavior for shared vs sole headers.

## 2. Registration data layer

- [x] 2.1 Extract the series lookup used by `deleteRegistration` into a provider helper that returns `(regSeries?, paySeries?)` for an event and person (design D1), and switch `deleteRegistration` to it. Verify that `test/features/guests/guest_registrations_test.dart` still passes.
- [x] 2.2 Add `updateRegistration(EventRegistrationParams)` to `IEventRegistrationsSource`, `EventRegistrationsLocalProvider`, and `EventDetailsRepository` (wrapped in `safeDbCall`). Add `EventRegistrationsDao.updateRegistration` for the row. Implement the transaction flow from design D4. Verify with a new `test/features/event_details/update_registration_test.dart` covering:
  - an amount change keeps series and entry numbers
  - bank to staff collection rewrites the payment series in place
  - a two-guest shared header leaves the other guest unchanged
  - a guest made free removes the payment series
  - a staff member going from net 0 to net > 0 posts a new journal
  - a date change in a shared header
  - a forced failure rolls back the row and the journals
- [x] 2.3 Add `bankInfo`, `assignmentInfo`, `snacksAssignmentStatus`, and `snacksAssignmentInfo` to `EventRegistrationModel` (constructor, `copyWith`, `toMap`/`fromMap`). Populate them in `fetchAllRegistrations`: snacks data from the existing DAO join, and bank/staff from a new two-query journals lookup (design D5). Verify with a test in `update_registration_test.dart` asserting the fields for a bank-paid guest, a staff-collected guest, a fund-snacks free guest, and a staff registration.

## 3. Presentation

- [x] 3.1 Add `EventRegistrationsCubit.updateRegistration(params)` following the `registerGuest` loading, call, and refetch pattern. Verify that `flutter analyze` is clean and that the list refreshes after an edit in the running app.
- [x] 3.2 Add edit mode to `AttendGuestModalView` and `AttendMemberModalView` via an optional `initial` registration: prefill all fields, make the person field read-only, use the edit title, and submit with `id` set (design D6). Verify in the app that editing a bank-paid guest shows the stored bank, amounts, date, and description, and that the person cannot be changed.
- [x] 3.3 Wire `onEdit` on registration tiles in `registrations_tab_view.dart`: `null` when the event is closed, otherwise open the guest or member modal by role and call `updateRegistration`. Verify in the app that the edit icon is shown on an open event and hidden on a closed one.
- [x] 3.4 Add the counterparty line and the gross/discount breakdown to the tile (design D7), with new keys in the fa and en ARB files, then regenerate l10n with `flutter pub run build_runner build`. Verify in the app, with a bank-paid guest, a staff-collected guest, a free guest, a staff member, and a discounted registration, that each shows the right text in Persian (RTL) and English.

## 4. Integration check

- [x] 4.1 Run `flutter analyze` and `flutter test` (both clean). Then in the app: register two guests together, edit one guest's amount, bank, and date, and confirm in the journals screen that the entry number is unchanged, the other guest's lines are intact, and the trial balance still balances.
- [x] 4.2 Run `graphify update .` to refresh the knowledge graph after the code changes.

## Workflow follow-up

- Before archiving the baseline change `document-baseline-capabilities`, reword its `journal-posting` "Journal date applies to all lines" requirement to apply at posting time (see proposal Impact).
- Archive this change once implementation is reviewed.
