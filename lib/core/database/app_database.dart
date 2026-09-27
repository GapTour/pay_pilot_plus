import 'package:drift/drift.dart';
import 'package:pay_pilot_plus/core/data/enums/accounting_nature_type.dart';
import 'package:pay_pilot_plus/core/database/daos/accounts_chart/accounts_chart_dao.dart';
import 'package:pay_pilot_plus/core/database/daos/banks/banks_dao.dart';
import 'package:pay_pilot_plus/core/database/daos/detailed_accounts/detailed_accounts_dao.dart';
import 'package:pay_pilot_plus/core/database/daos/event_ads/event_ads_dao.dart';
import 'package:pay_pilot_plus/core/database/daos/event_entrance_fees/event_entrance_fees_dao.dart';
import 'package:pay_pilot_plus/core/database/daos/event_orders/event_orders_dao.dart';
import 'package:pay_pilot_plus/core/database/daos/event_registrations/event_registrations_dao.dart';
import 'package:pay_pilot_plus/core/database/daos/events/events_dao.dart';
import 'package:pay_pilot_plus/core/database/daos/fund_allocations/fund_allocations_dao.dart';
import 'package:pay_pilot_plus/core/database/daos/fund_balances/fund_balances_dao.dart';
import 'package:pay_pilot_plus/core/database/daos/funds/funds_dao.dart';
import 'package:pay_pilot_plus/core/database/daos/journals/journals_dao.dart';
import 'package:pay_pilot_plus/core/database/daos/member_allocations/member_allocations_dao.dart';
import 'package:pay_pilot_plus/core/database/daos/menu_items/menu_items_dao.dart';
import 'package:pay_pilot_plus/core/database/daos/subsidiary_accounts/subsidiary_accounts_dao.dart';
import 'package:pay_pilot_plus/core/database/daos/team_funds/team_funds_dao.dart';
import 'package:pay_pilot_plus/core/database/daos/team_members/team_members_dao.dart';
import 'package:pay_pilot_plus/core/database/daos/teams/teams_dao.dart';
import 'package:pay_pilot_plus/core/database/daos/users/users_dao.dart';

part '../data/enums/account_group_type.dart';
part '../data/enums/general_account_type.dart';
part '../data/enums/subsidiary_account_type.dart';
part 'app_database.g.dart';
part 'tables/account_groups.dart';
part 'tables/banks.dart';
part 'tables/detailed_accounts.dart';
part 'tables/event_ads.dart';
part 'tables/event_entrance_fees.dart';
part 'tables/event_orders.dart';
part 'tables/event_registrations.dart';
part 'tables/events.dart';
part 'tables/fund_allocations.dart';
part 'tables/fund_balances.dart';
part 'tables/funds.dart';
part 'tables/general_accounts.dart';
part 'tables/journal_headers.dart';
part 'tables/journal_lines.dart';
part 'tables/member_allocations.dart';
part 'tables/menu_items.dart';
part 'tables/subsidiary_accounts.dart';
part 'tables/team_funds.dart';
part 'tables/team_members.dart';
part 'tables/teams.dart';
part 'tables/users.dart';

@DriftDatabase(
  tables: [
    AccountGroups,
    Banks,
    DetailedAccounts,
    EventOrders,
    EventRegistrations,
    EventEntranceFees,
    EventAds,
    Events,
    FundAllocations,
    FundBalances,
    Funds,
    GeneralAccounts,
    JournalHeaders,
    JournalLines,
    MemberAllocations,
    MenuItems,
    SubsidiaryAccounts,
    TeamFunds,
    TeamMembers,
    Teams,
    Users,
  ],
  daos: [
    AccountsChartDao,
    BanksDao,
    DetailedAccountsDao,
    EventOrdersDao,
    EventRegistrationsDao,
    EventsDao,
    FundAllocationsDao,
    FundBalancesDao,
    FundsDao,
    JournalsDao,
    MemberAllocationsDao,
    MenuItemsDao,
    SubsidiaryAccountsDao,
    TeamFundsDao,
    TeamMembersDao,
    TeamsDao,
    UsersDao,
    EventEntranceFeesDao,
    EventAdsDao,
  ],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase(super.executor);

  @override
  int get schemaVersion => 1;

  @override
  MigrationStrategy get migration {
    return MigrationStrategy(
      onCreate: (Migrator m) async {
        await m.createAll();
      },
      // onUpgrade: (m, from, to) {},
      beforeOpen: (openingDetails) async {
        await customStatement(
          'PRAGMA foreign_keys = ON',
        ); // Enable foreign key references in sqlite3.
      },
    );
  }

  Future<bool> columnExists(
    Migrator m,
    String sqlTableName,
    String sqlColumnName,
  ) async {
    final rows = await m.database
        .customSelect('PRAGMA table_info("$sqlTableName");')
        .get();
    return rows.any((r) => r.data['name'] == sqlColumnName);
  }
}

// dart run drift_dev schema dump lib/core/database/app_database.dart lib/core/database/drift_schemas/
// dart run drift_dev schema steps lib/core/database/drift_schemas/ lib/core/database/schema_versions.dart
// dart run build_runner build
