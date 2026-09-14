// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'accounts_chart_dao.dart';

// ignore_for_file: type=lint
mixin _$AccountsChartDaoMixin on DatabaseAccessor<AppDatabase> {
  $AccountGroupsTable get accountGroups => attachedDatabase.accountGroups;
  $GeneralAccountsTable get generalAccounts => attachedDatabase.generalAccounts;
  $SubsidiaryAccountsTable get subsidiaryAccounts =>
      attachedDatabase.subsidiaryAccounts;
  $UsersTable get users => attachedDatabase.users;
  $TeamsTable get teams => attachedDatabase.teams;
  $EventsTable get events => attachedDatabase.events;
  $BanksTable get banks => attachedDatabase.banks;
  $DetailedAccountsTable get detailedAccounts =>
      attachedDatabase.detailedAccounts;
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
  $$UsersTableTableManager get users =>
      $$UsersTableTableManager(_db.attachedDatabase, _db.users);
  $$TeamsTableTableManager get teams =>
      $$TeamsTableTableManager(_db.attachedDatabase, _db.teams);
  $$EventsTableTableManager get events =>
      $$EventsTableTableManager(_db.attachedDatabase, _db.events);
  $$BanksTableTableManager get banks =>
      $$BanksTableTableManager(_db.attachedDatabase, _db.banks);
  $$DetailedAccountsTableTableManager get detailedAccounts =>
      $$DetailedAccountsTableTableManager(
        _db.attachedDatabase,
        _db.detailedAccounts,
      );
}
