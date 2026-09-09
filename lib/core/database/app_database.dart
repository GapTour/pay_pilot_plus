import 'package:drift/drift.dart';
import 'package:pay_pilot_plus/core/database/daos/banks/banks_dao.dart';
import 'package:pay_pilot_plus/core/database/daos/detailed_accounts/detailed_accounts_dao.dart';
import 'package:pay_pilot_plus/core/database/daos/event_orders/event_orders_dao.dart';
import 'package:pay_pilot_plus/core/database/daos/event_partner_shares/event_partner_shares_dao.dart';
import 'package:pay_pilot_plus/core/database/daos/event_registrations/event_registrations_dao.dart';
import 'package:pay_pilot_plus/core/database/daos/events/events_dao.dart';
import 'package:pay_pilot_plus/core/database/daos/journals/journals_dao.dart';
import 'package:pay_pilot_plus/core/database/daos/menu_items/menu_items_dao.dart';
import 'package:pay_pilot_plus/core/database/daos/settings_dao/settings_dao.dart';
import 'package:pay_pilot_plus/core/database/daos/subsidiary_accounts/subsidiary_accounts_dao.dart';
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
part 'tables/event_orders.dart';
part 'tables/event_partner_shares.dart';
part 'tables/event_registrations.dart';
part 'tables/events.dart';
part 'tables/general_accounts.dart';
part 'tables/journal_headers.dart';
part 'tables/journal_lines.dart';
part 'tables/menu_items.dart';
part 'tables/subsidiary_accounts.dart';
part 'tables/team_members.dart';
part 'tables/teams.dart';
part 'tables/users.dart';

@DriftDatabase(
  tables: [
    AccountGroups,
    GeneralAccounts,
    SubsidiaryAccounts,
    DetailedAccounts,
    JournalHeaders,
    JournalLines,
    Events,
    Users,
    Banks,
    Teams,
    TeamMembers,
    MenuItems,
    EventOrders,
    EventPartnerShares,
    EventRegistrations,
  ],
  daos: [
    UsersDao,
    TeamsDao,
    TeamMembersDao,
    MenuItemsDao,
    BanksDao,
    EventsDao,
    EventOrdersDao,
    EventRegistrationsDao,
    DetailedAccountsDao,
    SubsidiaryAccountsDao,
    EventPartnerSharesDao,
    JournalsDao,
    SettingsDao,
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
        await _seedDefaultAccountGroups();
        await _seedDefaultGeneralAccounts();
        await _seedDefaultSubsidiaryAccounts();
      },
      // onUpgrade: (m, from, to) {},
      beforeOpen: (openingDetails) async {
        await customStatement(
          'PRAGMA foreign_keys = ON',
        ); // Enable foreign key references in sqlite3.
      },
    );
  }

  Future<void> _seedDefaultAccountGroups() async {
    final hasAccounts = await (select(
      accountGroups,
    )..limit(1)).getSingleOrNull();

    if (hasAccounts != null) return;

    await transaction(() async {
      final companions = AccountGroupType.values
          .map(
            (group) => AccountGroupsCompanion.insert(
              code: group.prefix,
              name: group.title,
              type: group,
            ),
          )
          .toList();

      await batch((b) {
        b.insertAll(accountGroups, companions, mode: InsertMode.insertOrIgnore);
      });
    });
  }

  Future<void> _seedDefaultGeneralAccounts() async {
    final hasAccounts = await (select(
      generalAccounts,
    )..limit(1)).getSingleOrNull();

    if (hasAccounts != null) return;

    await transaction(() async {
      final accountGroupsList = await select(accountGroups).get();

      final companions = GeneralAccountType.values.map((general) {
        final groupID = accountGroupsList
            .firstWhere((e) => e.type == general.type)
            .id;
        return GeneralAccountsCompanion.insert(
          code: general.prefix,
          name: general.title,
          type: general,
          groupID: groupID,
        );
      }).toList();

      await batch((b) {
        b.insertAll(
          generalAccounts,
          companions,
          mode: InsertMode.insertOrIgnore,
        );
      });
    });
  }

  Future<void> _seedDefaultSubsidiaryAccounts() async {
    final hasAccounts = await (select(
      subsidiaryAccounts,
    )..limit(1)).getSingleOrNull();

    if (hasAccounts != null) return;

    await transaction(() async {
      final generalAccountsList = await select(generalAccounts).get();
      final companions = SubsidiaryAccountType.values.map((sub) {
        final generalID = generalAccountsList
            .firstWhere((e) => e.type == sub.type)
            .id;

        return SubsidiaryAccountsCompanion.insert(
          code: sub.prefix,
          name: sub.title,
          type: sub,
          generalId: generalID,
        );
      }).toList();

      await batch((b) {
        b.insertAll(
          subsidiaryAccounts,
          companions,
          mode: InsertMode.insertOrIgnore,
        );
      });
    });
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
// dart run build_runner build --force-jit
