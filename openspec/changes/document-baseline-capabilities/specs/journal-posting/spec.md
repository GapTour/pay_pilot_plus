# Spec Delta

## Purpose

Defines the double-entry rules every accounting journal obeys, so that the books stay balanced and each posting can be traced to the people, events, and business action behind it.

## ADDED Requirements

### Requirement: Balanced journals
The system SHALL reject a journal whose total debit does not equal its total credit, and SHALL save nothing from a rejected journal.

#### Scenario: Unbalanced journal is rejected
- **WHEN** a journal with total debit 1,000 and total credit 900 is submitted
- **THEN** the journal is rejected with an unbalanced-journal error naming both totals
- **AND** no header or lines are stored

#### Scenario: Balanced journal is stored atomically
- **WHEN** a balanced journal is submitted
- **THEN** its header and all of its lines are stored together, or none are

### Requirement: Single-sided non-negative lines
Each journal line SHALL carry a debit and a credit that are both zero or positive, and at most one of them SHALL be non-zero. Amounts SHALL be whole numbers in the base currency unit, with no fractional values.

#### Scenario: Negative amount is refused
- **WHEN** a line with a negative debit is stored
- **THEN** the database refuses the line

#### Scenario: Two-sided line is refused
- **WHEN** a line with both debit and credit greater than zero is stored
- **THEN** the database refuses the line

### Requirement: Line account tagging
Each journal line SHALL reference exactly one subsidiary account, and MAY reference up to two detailed accounts: a first detailed account (whose balance the line affects) and a second detailed account (its counterparty, for example the event).

#### Scenario: Guest registration line tags guest and event
- **WHEN** a guest's registration receivable is posted
- **THEN** the line's first detailed account is the guest and its second detailed account is the event

### Requirement: Sequential entry numbers
Each new journal header SHALL receive a unique entry number made of a prefix (default `JV-`) and a zero-padded sequence (default width 4) one greater than the highest numeric sequence already used for that prefix.

#### Scenario: Numbering continues past padding width
- **WHEN** the highest existing entry number is `JV-9999`
- **THEN** the next entry number is `JV-10000`

### Requirement: Series groups one business action
Every journal line SHALL carry a series identifier. All lines produced by one business action (for example one registration, one payment, or one event close) SHALL share the same series, so the action can be found or reversed as a unit.

#### Scenario: Event close lines share a series
- **WHEN** an event is closed
- **THEN** all journal lines and fund balance rows written by that close share one series

### Requirement: Journal date applies to all lines
A journal's entry date SHALL be copied to every one of its lines.

#### Scenario: Lines inherit the header date
- **WHEN** a journal dated 1403/05/10 is stored
- **THEN** each of its lines is dated 1403/05/10

### Requirement: Single opening journal
The system SHALL keep at most one opening journal, dated the first day of the current Jalali year. Opening balances added later SHALL be appended to that same journal and SHALL also be balanced.

#### Scenario: Second opening balance reuses the header
- **WHEN** an opening bank balance is recorded and an opening journal already exists
- **THEN** the new lines are added to the existing opening journal and no new header is created
