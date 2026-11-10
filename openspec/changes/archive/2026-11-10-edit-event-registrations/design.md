# Design

## Context

See proposal.md for motivation and specs/event-registration/spec.md for required behavior.

Current state that shapes the approach:

- A registration row (`EventRegistrations`) stores amounts, status, date, description, and snacks assignment (staff or fund). It does **not** store the payment counterparty (bank or collecting staff) or the series of its journals.
- Registering guests posts up to two journals, each with **one header shared by all guests registered together**, and a **separate series per guest**:
  - registration series `...-regUSR<user>EVN<event>`: Cr event revenue (gross), Dr sale discounts, Dr guest receivables (net)
  - payment series, one of:
    - `...-recUSR..`: Cr guest receivables, Dr bank (detailed = bank)
    - `...-payUSR..`: Cr guest receivables, Dr accounts payable (detailed = collecting staff)
- Staff registrations post only a registration series `...-regSTF..` (Dr payable instead of receivables), and nothing at all when net is 0.
- Delete already finds these series without stored links, by matching account tags: the revenue line (first detailed = event, second = person), then the receivables credit line (first = person, second = event). `(eventID, userID)` is unique on registrations, so each lookup has at most one match.
- `JournalsDao.updateJournal` replaces **all** lines of a header, which would wipe other guests' lines in a shared header. It cannot be reused.

## Goals / Non-Goals

**Goals:**
- Edit one registration's row and its two series atomically, in place.
- Show the payment counterparty on tiles without a schema migration.

**Non-Goals:**
- Changing the registered person.
- Making the existing `registerGuests` / `registerMembers` / `deleteRegistration` flows atomic (same known gap as event closing; separate change).
- Editing anything on a closed event, or re-running closing postings.
- Updating the shared header's description text (it lists guest names only, which do not change).

## Decisions

### D1. Find series by account tags, don't store them
Reuse delete's lookup to resolve the registration series and payment series for `(event account, person account)`. Factor it into one provider helper used by edit, delete, and the tile query.

- *Alternative*: add `registrationSeries` / `paymentSeries` columns to `EventRegistrations`. More direct, but needs a schema bump plus a backfill that runs the same lookup anyway. Defer until a lookup proves ambiguous.

### D2. New `JournalsDao.replaceSeriesLines`
A new DAO method, `replaceSeriesLines({series, lines, date})`, runs in a transaction:
1. Load the existing lines of `series` and take their header (exactly one is expected; throw otherwise).
2. Check that `lines` balance, using the same check and error as `insertJournal`.
3. Delete that series' lines, then insert `lines` with the same `headerId`, `series`, and `date`.
4. If `lines` is empty, the header is deleted when no lines remain (same as `deleteJournalsLines`).
5. If every remaining line in the header belongs to this series, set the header `entryDate` to `date`.

Callers handle the "series did not exist" case themselves, by posting through `insertJournal`.

- *Alternative*: delete the series and re-post. Rejected by the user: it changes entry numbers.

### D3. Helpers accept an existing series
`RecordEventJournalsHelper.identificationGuestAttending` / `identificationStaffAttending`, `RecordTransferringJournalsHelper.registerPaymentFromGuest`, and `RecordAssignmentJournalsHelper.fromGuestsToStaff` get an optional `String? series`. When it is given, the helper uses it instead of generating one. Edit always calls them with a single person, so one series per call holds. Existing callers are unchanged.

### D4. `updateRegistration` in the registrations provider
Add `updateRegistration(EventRegistrationParams params)` to `IEventRegistrationsSource`, reusing the existing params class (`id` is already nullable; `guestsInfo` has exactly one entry). The whole body runs inside one `transaction` on the shared `AppDatabase`, so the DAOs' own nested transactions join it:

```
transaction {
  update registration row (amounts, status, date, description, snacks assignment)
  (regSeries, paySeries) = lookup(eventAccount, personAccount)
  regLines = guest ? identificationGuestAttending(series: regSeries)
                   : identificationStaffAttending(series: regSeries)   // [] when staff net == 0
  payLines = guest && confirmed && net > 0
             ? (bank ? registerPaymentFromGuest : fromGuestsToStaff)(series: paySeries)
             : []
  for (series, lines) in [(regSeries, regLines), (paySeries, payLines)]:
    existing series -> replaceSeriesLines(series, lines, date)
    no series, lines non-empty -> insertJournal(new header, as registration does today)
    no series, no lines -> nothing
}
```

The repository wraps it in `safeDbCall`, like every other operation.

### D5. Counterparty on the model, mirroring params
Add four fields to `EventRegistrationModel`, using the same shapes as `EventRegistrationParams` so the edit form can be prefilled 1:1:
- `bankInfo` and `assignmentInfo`, each `({int id, String name})?`
- `snacksAssignmentStatus`
- `snacksAssignmentInfo`

Snacks data is already joined by `EventRegistrationsDao.fetchAllRegistrations`; map it into the model. Bank and collecting staff come from one new journals query per tab load:
- payment series = receivables credit lines with `secondDetailedId = eventAccount`
- then load all lines in those series (`series IN (...)`) with detailed accounts joined
- a bank line gives `bankInfo` (the detailed account's `bankID` plus its name)
- a payable line gives `assignmentInfo` (`userID` plus name)

That is two queries regardless of registration count; no N+1.

- *Alternative*: one lookup per tile. Simpler code, but N+1 queries on a list that can hold dozens of guests.

### D6. Edit mode in the existing modals
`AttendGuestModalView` and `AttendMemberModalView` take an optional `EventRegistrationModel? initial`. When it is set:
- the fields are prefilled
- the person field is read-only and shows the one person
- the title switches to the edit string
- submit emits params with `id: initial.id`

The tab's `onEdit` opens the matching modal by `item.user.role` (guest vs staff/host). `EventRegistrationsCubit.updateRegistration` follows the existing `registerGuest` pattern: loading, call, then refetch the list.

### D7. Tile text
One line under the date, in this priority:
1. `bankInfo`: deposited to X
2. `assignmentInfo`: received by X
3. snacks assigned to a staff member or fund: snacks charged to X
4. staff or host role: charged to own account

When `discountAmount > 0`, the tile also shows gross and discount. All labels are new ARB keys.

## Risks / Trade-offs

- [Lookup misses a series in legacy data, e.g. a registration whose journals were deleted by hand] → treated as "series did not exist": the edit posts fresh journals and the books still balance. The tile simply shows no counterparty.
- [More than one header for one series, which the current code never produces] → `replaceSeriesLines` throws, and the edit rolls back with an error instead of corrupting data.
- [Header date diverges from some line dates in shared headers] → accepted per the user's choice. Reports that filter by line date stay correct; reports that use the header date see the original date. The draft baseline `journal-posting` date rule needs rewording before it is archived (see proposal Impact).
- [Snacks assignment edits have no journal effect until closing] → expected. Closing reads the row, and the edit updates the row.
- [The guest modal is already ~27K and grows with edit mode] → acceptable for now. Splitting it is out of scope.

## Migration Plan

No schema change and no data migration. To roll back, revert the code: journals written by edits are ordinary balanced lines, so existing data stays valid.
