# Spec Delta

## Purpose

Covers correcting an event registration after it was recorded, keeping its accounting journals consistent, and showing on each registration who or what sits on the other side of its postings.

## ADDED Requirements

### Requirement: Edit action on open events
Each registration tile on the registrations tab SHALL offer an edit action while the event is open. The edit action SHALL NOT be available once the event is closed.

#### Scenario: Edit available on open event
- **WHEN** a user views the registrations tab of an open event
- **THEN** every registration tile offers an edit action

#### Scenario: Edit hidden on closed event
- **WHEN** a user views the registrations tab of a closed event
- **THEN** no registration tile offers an edit action

### Requirement: Edit form prefilled with current values
Choosing edit SHALL open the same form used to register that kind of person (guest or staff), prefilled with the registration's current date, gross, discount, and net amounts, settlement method and counterparty, snacks assignment, and description.

#### Scenario: Guest paid by bank is prefilled
- **WHEN** a user edits a guest registration whose payment was deposited to bank Blu
- **THEN** the form shows the stored amounts and date, settlement "deposit to bank", and bank Blu selected

### Requirement: Person cannot be changed
In edit mode, the person field SHALL be shown but not editable. Changing who is registered SHALL require deleting the registration and registering again.

#### Scenario: Person field is locked
- **WHEN** a user opens the edit form for Mansoure's registration
- **THEN** the person field shows Mansoure and cannot be changed

### Requirement: Registration journals rewritten in place
Saving an edit SHALL replace the journal lines of the registration's registration series and payment series with lines computed from the new values. Each replaced series SHALL keep its series identifier and stay in its original journal header, so entry numbers do not change.

#### Scenario: Amount correction keeps entry number
- **WHEN** a guest registration posted in journal JV-0012 is edited from net 300,000 to net 250,000
- **THEN** the guest's registration lines in JV-0012 reflect net 250,000 under the same series
- **AND** no new journal header is created

#### Scenario: Bank changed to staff collection
- **WHEN** a guest's settlement is changed from "deposit to bank Blu" to "collected by Mansoure"
- **THEN** the payment series no longer debits bank Blu and instead debits Mansoure's payable, under the same series and header

### Requirement: Other registrations are unaffected
An edit SHALL NOT change journal lines that belong to any other series, including other guests' lines in a journal header shared with the edited registration.

#### Scenario: Shared header with two guests
- **WHEN** guests A and B were registered together in one journal and A's registration is edited
- **THEN** B's journal lines are unchanged

### Requirement: Series added or removed by an edit
When an edit produces lines for a series the registration did not have (for example a payment once net becomes greater than zero), the system SHALL post them as a new journal. When an edit produces no lines for an existing series, the system SHALL remove that series, and SHALL remove its journal header if no lines remain.

#### Scenario: Guest becomes free
- **WHEN** a guest registration with net 200,000 paid to bank Blu is edited to a 100% discount
- **THEN** its payment series is removed and its registration series records the gross revenue offset by an equal discount

#### Scenario: Free staff member now pays
- **WHEN** a staff registration with net 0 is edited to net 100,000
- **THEN** a journal is posted charging 100,000 to that staff member's payable

### Requirement: Edited dates
An edit that changes the date SHALL set the new date on every rewritten line and on the registration. A journal header SHALL take the new date only when all of its lines belong to the edited registration.

#### Scenario: Date change in a shared header
- **WHEN** guest A's date is edited and A shares a journal header with guest B
- **THEN** A's lines and registration take the new date, while the header and B's lines keep the original date

### Requirement: Atomic edit
The registration row update and all journal changes for one edit SHALL succeed or fail together. A failed edit SHALL leave the registration and all journals exactly as they were.

#### Scenario: Failure rolls back
- **WHEN** writing the new journal lines of an edit fails
- **THEN** the registration row and both of its series still hold their pre-edit values

### Requirement: Balanced edits
The lines written for each replaced series SHALL balance (total debit equals total credit). An unbalanced replacement SHALL be rejected and the edit rolled back.

#### Scenario: Unbalanced replacement rejected
- **WHEN** an edit would write a series whose debits and credits differ
- **THEN** the edit fails with an unbalanced-journal error and nothing is changed

### Requirement: Settlement counterparty on tiles
Each registration tile SHALL show the other side of its settlement: "deposited to <bank>" for a guest paid by bank, "received by <staff>" for a guest whose payment a staff member collected, "snacks charged to <staff or fund>" for a free guest, and "charged to own account" for a staff member.

#### Scenario: Guest paid by bank
- **WHEN** the tab shows a guest whose payment was deposited to bank Blu
- **THEN** the tile shows "deposited to Blu"

#### Scenario: Guest paid via staff
- **WHEN** the tab shows a guest whose payment Mansoure collected
- **THEN** the tile shows "received by Mansoure"

#### Scenario: Staff registration
- **WHEN** the tab shows a staff member's registration
- **THEN** the tile shows "charged to own account"

### Requirement: Discount breakdown on tiles
When a registration has a discount greater than zero, its tile SHALL show the gross amount and discount amount in addition to the net amount.

#### Scenario: Discounted registration
- **WHEN** the tab shows a registration with gross 300,000, discount 50,000, and net 250,000
- **THEN** the tile shows all three amounts

#### Scenario: No discount
- **WHEN** the tab shows a registration with discount 0
- **THEN** the tile shows only the net amount
