// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'banks_dao.dart';

// ignore_for_file: type=lint
mixin _$BanksDaoMixin on DatabaseAccessor<AppDatabase> {
  $BanksTable get banks => attachedDatabase.banks;
  $UsersTable get users => attachedDatabase.users;
  $TeamsTable get teams => attachedDatabase.teams;
  $EventsTable get events => attachedDatabase.events;
  $DetailedAccountsTable get detailedAccounts =>
      attachedDatabase.detailedAccounts;
  BanksDaoManager get managers => BanksDaoManager(this);
}

class BanksDaoManager {
  final _$BanksDaoMixin _db;
  BanksDaoManager(this._db);
  $$BanksTableTableManager get banks =>
      $$BanksTableTableManager(_db.attachedDatabase, _db.banks);
  $$UsersTableTableManager get users =>
      $$UsersTableTableManager(_db.attachedDatabase, _db.users);
  $$TeamsTableTableManager get teams =>
      $$TeamsTableTableManager(_db.attachedDatabase, _db.teams);
  $$EventsTableTableManager get events =>
      $$EventsTableTableManager(_db.attachedDatabase, _db.events);
  $$DetailedAccountsTableTableManager get detailedAccounts =>
      $$DetailedAccountsTableTableManager(
        _db.attachedDatabase,
        _db.detailedAccounts,
      );
}
