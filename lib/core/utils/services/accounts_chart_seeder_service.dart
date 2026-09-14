import 'package:drift/drift.dart';
import 'package:pay_pilot_plus/core/database/app_database.dart';

class AccountsChartSeederService {
  AccountsChartSeederService(this._database);

  final AppDatabase _database;

  Future<void> seedDefaultChartOfAccounts() {
    return _database.transaction(() async {
      for (final groupType in AccountGroupType.values) {
        await _ensureAccountGroup(groupType);
      }

      for (final generalType in GeneralAccountType.values) {
        await _ensureGeneralAccount(generalType);
      }

      for (final subsidiaryType in SubsidiaryAccountType.values) {
        await _ensureSubsidiaryAccount(subsidiaryType);
      }
    });
  }

  Future<AccountGroup> _ensureAccountGroup(AccountGroupType groupType) async {
    final existing = await (_database.select(
      _database.accountGroups,
    )..where((table) => table.code.equals(groupType.prefix))).getSingleOrNull();

    if (existing != null) return existing;

    await _database
        .into(_database.accountGroups)
        .insert(
          AccountGroupsCompanion.insert(
            code: groupType.prefix,
            name: groupType.title,
            type: groupType,
            isSystemDefault: Value(true),
          ),
          mode: InsertMode.insertOrIgnore,
        );

    return (_database.select(
      _database.accountGroups,
    )..where((table) => table.code.equals(groupType.prefix))).getSingle();
  }

  Future<GeneralAccount> _ensureGeneralAccount(
    GeneralAccountType generalAccount,
  ) async {
    final existing =
        await (_database.select(_database.generalAccounts)
              ..where((table) => table.code.equals(generalAccount.prefix)))
            .getSingleOrNull();

    if (existing != null) return existing;

    final group = await _ensureAccountGroup(generalAccount.accountGroupType);

    await _database
        .into(_database.generalAccounts)
        .insert(
          GeneralAccountsCompanion.insert(
            completeCode: generalAccount.completeCode,
            code: generalAccount.prefix,
            name: generalAccount.title,
            accountGroupId: group.id,
            type: generalAccount,
            isSystemDefault: Value(true),
          ),
          mode: InsertMode.insertOrIgnore,
        );

    return (_database.select(
      _database.generalAccounts,
    )..where((table) => table.code.equals(generalAccount.prefix))).getSingle();
  }

  Future<SubsidiaryAccount> _ensureSubsidiaryAccount(
    SubsidiaryAccountType subsidiaryAccount,
  ) async {
    final existing =
        await (_database.select(_database.subsidiaryAccounts)
              ..where((table) => table.code.equals(subsidiaryAccount.prefix)))
            .getSingleOrNull();

    if (existing != null) return existing;

    final general = await _ensureGeneralAccount(
      subsidiaryAccount.generalAccountType,
    );
    final group = await _ensureAccountGroup(subsidiaryAccount.accountGroupType);

    await _database
        .into(_database.subsidiaryAccounts)
        .insert(
          SubsidiaryAccountsCompanion.insert(
            completeCode: subsidiaryAccount.completeCode,
            code: subsidiaryAccount.prefix,
            name: subsidiaryAccount.title,
            accountGroupId: group.id,
            generalAccountId: general.id,
            type: subsidiaryAccount,
            isSystemDefault: Value(true),
          ),
          mode: InsertMode.insertOrIgnore,
        );

    return (_database.select(_database.subsidiaryAccounts)
          ..where((table) => table.code.equals(subsidiaryAccount.prefix)))
        .getSingle();
  }
}
