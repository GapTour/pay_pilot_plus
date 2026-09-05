// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'detailed_accounts_dao.dart';

// ignore_for_file: type=lint
mixin _$DetailedAccountsDaoMixin on DatabaseAccessor<AppDatabase> {
  $UsersTable get users => attachedDatabase.users;
  $TeamsTable get teams => attachedDatabase.teams;
  $EventsTable get events => attachedDatabase.events;
  $BanksTable get banks => attachedDatabase.banks;
  $DetailedAccountsTable get detailedAccounts =>
      attachedDatabase.detailedAccounts;
  DetailedAccountsDaoManager get managers => DetailedAccountsDaoManager(this);
}

class DetailedAccountsDaoManager {
  final _$DetailedAccountsDaoMixin _db;
  DetailedAccountsDaoManager(this._db);
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
