# Spec Delta

## Purpose

Defines the fixed account hierarchy every journal line is posted against, and how per-entity detailed accounts are created so balances can be reported per person, event, and bank.

## ADDED Requirements

### Requirement: Four-level account hierarchy
The system SHALL organize accounts in four levels: account group, general account, subsidiary account, and detailed account. Every general account SHALL belong to one account group, and every subsidiary account SHALL belong to one general account and one account group.

#### Scenario: Subsidiary account is linked to its parents
- **WHEN** the chart of accounts is inspected
- **THEN** every subsidiary account references exactly one general account and one account group

### Requirement: Fixed system account set
The system SHALL provide five account groups (assets 10, liabilities 20, equity 30, revenues 40, expenses 50), the general accounts 11, 12, 13, 21, 31, 32, 41, 42, 51, 52, and the subsidiary accounts defined by the app, including cash, bank, guest receivables, accounts payable, partner equity, opening and closing balance, event revenue, sale discounts, entrance, snacks, salary, ads, bank fee, and other expenses.

#### Scenario: Required subsidiary accounts exist
- **WHEN** the app has started at least once
- **THEN** a subsidiary account exists for each defined subsidiary type, flagged as a system default

### Requirement: Hierarchical account codes
A general account's complete code SHALL be its group code followed by its own code. A subsidiary account's complete code SHALL be its group code, then its general account code, then its own four-digit code. Codes SHALL be unique.

#### Scenario: Salary expense complete code
- **WHEN** the salary expense subsidiary account (code 0521, general 52, group 50) is created
- **THEN** its complete code is `50520521`

### Requirement: Idempotent seeding at startup
On every app start, the system SHALL ensure all system accounts exist, creating only those that are missing, in a single transaction. Existing accounts SHALL NOT be duplicated or altered.

#### Scenario: Restart does not duplicate accounts
- **WHEN** the app starts with a fully seeded database
- **THEN** no account rows are added or changed

#### Scenario: Missing account is restored
- **WHEN** the app starts and one system subsidiary account is missing
- **THEN** that account is created with its parent links and the rest are left untouched

### Requirement: Detailed accounts per entity
The system SHALL create one detailed account when a user (guest, host, or staff), event, or bank is created, linked to that entity. Detailed account types are user, event, bank, cash, and other. Each entity SHALL have at most one detailed account.

#### Scenario: Creating a guest creates their account
- **WHEN** a new guest is created
- **THEN** a detailed account of type user is created and linked to that guest

### Requirement: Detailed account code sequence
A detailed account code SHALL be a type prefix (user 10, event 20, bank 30, cash 40, other 90) followed by a five-digit sequence that is one greater than the highest numeric sequence already used for that prefix, starting at 1.

#### Scenario: First event account
- **WHEN** the first event detailed account is created
- **THEN** its code is `2000001`

#### Scenario: Sequence compares numerically
- **WHEN** the highest existing user code is `1099999`
- **THEN** the next user code is `10100000`, not a duplicate
