# Proposal

## Why

OpenSpec was adopted mid-project, so the accounting core has no specs. Upcoming fixes (atomic event closing, moving funds into the books, validating profit splits) will modify this behavior, and they need a recorded baseline to diff against. This change records how the system behaves **today**; it changes no code.

## What Changes

- Record the current chart-of-accounts structure, account coding, and startup seeding as a spec.
- Record the current journal-posting rules (balanced entries, line constraints, entry numbering, series grouping, opening journal) as a spec.
- Record the current event-closing flow (snacks and entrance cost recognition, profit calculation, fund allocation, salary recognition, closed flag) as a spec.
- No code changes. Known defects are deliberately **not** encoded as requirements; where current behavior is questionable, the spec states the behavior as-is and the defect is listed under "Known gaps" below for follow-up changes.

## Capabilities

### New Capabilities
- `chart-of-accounts`: Four-level account hierarchy (group, general, subsidiary, detailed), code formats, system-default seeding, and per-entity detailed accounts.
- `journal-posting`: Rules every journal entry obeys: double-entry balance, line-level amount constraints, two-level detailed tagging, entry numbering, series grouping, and the single opening journal.
- `event-closing`: Closing an event: recognizing snacks and entrance costs owed to the host, computing event profit, allocating profit to funds and to staff as salaries, and marking the event closed.

### Modified Capabilities
_None. No specs exist yet._

## Known gaps (out of scope, for follow-up changes)

- Event closing is not atomic: each journal commits separately, so a mid-way failure leaves partial postings on an open event and a retry duplicates them.
- Fund balances live in a separate `FundBalances` ledger, outside the double-entry books.
- Fund and member share percentages are not validated to sum to 100% together.
- A loss-making event is floored to zero profit; the loss is not assigned to anyone.
- Share amounts use integer division, so remainders are dropped.
- The closing guest count includes absent and cancelled registrations, so snacks are charged for them.

## Impact

- Adds `openspec/specs/chart-of-accounts`, `openspec/specs/journal-posting`, `openspec/specs/event-closing` on archive.
- No changes to application code, database schema, or dependencies.
- Code these specs describe: `lib/core/data/enums/`, `lib/core/database/tables/`, `lib/core/database/daos/journals/`, `lib/core/database/daos/detailed_accounts/`, `lib/core/utils/services/accounts_chart_seeder_service.dart`, `lib/core/utils/helpers/record_*_journals_helper.dart`, `lib/features/events/data/providers/event_local_provider.dart`.
