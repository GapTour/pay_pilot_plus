// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'subsidiary_accounts_dao.dart';

// ignore_for_file: type=lint
mixin _$SubsidiaryAccountsDaoMixin on DatabaseAccessor<AppDatabase> {
  $AccountGroupsTable get accountGroups => attachedDatabase.accountGroups;
  $GeneralAccountsTable get generalAccounts => attachedDatabase.generalAccounts;
  $SubsidiaryAccountsTable get subsidiaryAccounts =>
      attachedDatabase.subsidiaryAccounts;
  SubsidiaryAccountsDaoManager get managers =>
      SubsidiaryAccountsDaoManager(this);
}

class SubsidiaryAccountsDaoManager {
  final _$SubsidiaryAccountsDaoMixin _db;
  SubsidiaryAccountsDaoManager(this._db);
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
