// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'accounts_chart_dao.dart';

// ignore_for_file: type=lint
mixin _$AccountsChartDaoMixin on DatabaseAccessor<AppDatabase> {
  $AccountGroupsTable get accountGroups => attachedDatabase.accountGroups;
  $GeneralAccountsTable get generalAccounts => attachedDatabase.generalAccounts;
  $SubsidiaryAccountsTable get subsidiaryAccounts =>
      attachedDatabase.subsidiaryAccounts;
  AccountsChartDaoManager get managers => AccountsChartDaoManager(this);
}

class AccountsChartDaoManager {
  final _$AccountsChartDaoMixin _db;
  AccountsChartDaoManager(this._db);
  $$AccountGroupsTableTableManager get accountGroups =>
      $$AccountGroupsTableTableManager(_db.attachedDatabase, _db.accountGroups);
  $$GeneralAccountsTableTableManager get generalAccounts =>
      $$GeneralAccountsTableTableManager(
        _db.attachedDatabase,
        _db.generalAccounts,
      );
  $$SubsidiaryAccountsTableTableManager get subsidiaryAccounts =>
      $$SubsidiaryAccountsTableTableManager(
        _db.attachedDatabase,
        _db.subsidiaryAccounts,
      );
}
