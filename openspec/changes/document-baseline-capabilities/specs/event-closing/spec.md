# Spec Delta

## Purpose

Defines what happens when an event is closed: host costs are recognized, the event's profit is computed, and that profit is distributed to funds and to staff as salaries. This describes current behavior, including known gaps listed in the change proposal.

## ADDED Requirements

### Requirement: Closing inputs
To close an event, the user SHALL supply a per-person snacks fee, a total entrance fee, and the staff members who attended. The guest count used for closing SHALL be the number of registrations for the event, regardless of registration status or absence.

#### Scenario: Absent registrations are still counted
- **WHEN** an event with 10 registrations, 2 of them marked absent, is closed
- **THEN** snacks costs are calculated for 10 registered guests

### Requirement: Snacks cost owed to host
On close, the system SHALL credit the host's payable with the snacks fee multiplied by (registered guests + attending staff). It SHALL debit each attending staff member's payable with one snacks fee, debit the payable of any staff member a guest's snacks were assigned to with one snacks fee, and debit snacks expense for the remaining guests.

#### Scenario: Snacks posting balances
- **WHEN** an event with 10 registered guests, 2 attending staff, 1 guest's snacks assigned to staff, and a snacks fee of 50,000 is closed
- **THEN** the host's payable is credited 600,000
- **AND** each attending staff payable is debited 50,000, the assigned staff payable is debited 50,000, and snacks expense is debited 450,000

### Requirement: Snacks assigned to a fund
For each registration whose snacks were assigned to a fund, the system SHALL record a fund balance credit of one snacks fee against that fund, outside the journal books. These snacks remain in snacks expense in the books.

#### Scenario: Fund pays a guest's snacks
- **WHEN** an event is closed with one guest's snacks assigned to fund F and a snacks fee of 50,000
- **THEN** fund F's balance records a credit of 50,000 under the close series

### Requirement: Entrance cost owed to host
On close, when the entrance fee is greater than zero, the system SHALL debit entrance expense and credit the host's payable by the entrance fee. When the entrance fee is zero, no entrance journal SHALL be posted.

#### Scenario: Zero entrance fee
- **WHEN** an event is closed with an entrance fee of 0
- **THEN** no entrance expense journal is created

### Requirement: Event profit calculation
Event profit SHALL equal event revenue credits, minus sale discounts, entrance, snacks, ads, bank fee, and other expense debits tagged to the event, plus the snacks fees paid by funds. A negative result SHALL be treated as zero profit.

#### Scenario: Loss is floored to zero
- **WHEN** an event's expenses exceed its net revenue
- **THEN** its profit is zero and no fund or salary allocation is recorded

### Requirement: Fund share of profit
For each fund allocation on the event, the system SHALL record a fund balance debit of profit multiplied by the fund's share percentage, divided by 100 using integer division. These amounts are recorded outside the journal books.

#### Scenario: Fund receives its percentage
- **WHEN** an event with profit 1,000,000 and a fund allocated 20% is closed
- **THEN** that fund's balance records a debit of 200,000

### Requirement: Staff salaries from profit
For each member allocation on the event, the system SHALL compute a salary of profit multiplied by the member's share percentage, divided by 100 using integer division. It SHALL post one journal that debits salary expense by the total and credits each member's payable by their salary.

#### Scenario: Salaries are credited to members
- **WHEN** an event with profit 1,000,000 and members A at 30% and B at 50% is closed
- **THEN** salary expense is debited 800,000, A's payable is credited 300,000, and B's payable is credited 500,000

### Requirement: Shared close series
All journal lines and fund balance rows written while closing one event SHALL share a single series identifier.

#### Scenario: Close postings are traceable
- **WHEN** an event is closed
- **THEN** its snacks, entrance, salary, and fund balance records carry the same series

### Requirement: Closed events are read-only
After closing, the system SHALL mark the event closed and store the snacks fee and entrance fee used. The event details screen SHALL no longer allow editing or deleting its registrations, expenses, or share allocations.

#### Scenario: Editing is disabled after close
- **WHEN** a user opens a closed event's details
- **THEN** edit and delete actions for registrations, expenses, and share partners are unavailable
