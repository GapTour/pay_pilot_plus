// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'journals_dao.dart';

// ignore_for_file: type=lint
mixin _$JournalsDaoMixin on DatabaseAccessor<AppDatabase> {
  $JournalHeadersTable get journalHeaders => attachedDatabase.journalHeaders;
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
  $JournalLinesTable get journalLines => attachedDatabase.journalLines;
  JournalsDaoManager get managers => JournalsDaoManager(this);
}

class JournalsDaoManager {
  final _$JournalsDaoMixin _db;
  JournalsDaoManager(this._db);
  $$JournalHeadersTableTableManager get journalHeaders =>
      $$JournalHeadersTableTableManager(
        _db.attachedDatabase,
        _db.journalHeaders,
      );
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
  $$JournalLinesTableTableManager get journalLines =>
      $$JournalLinesTableTableManager(_db.attachedDatabase, _db.journalLines);
}
