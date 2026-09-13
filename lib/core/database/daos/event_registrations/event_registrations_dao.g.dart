// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'event_registrations_dao.dart';

// ignore_for_file: type=lint
mixin _$EventRegistrationsDaoMixin on DatabaseAccessor<AppDatabase> {
  $TeamsTable get teams => attachedDatabase.teams;
  $UsersTable get users => attachedDatabase.users;
  $EventsTable get events => attachedDatabase.events;
  $EventRegistrationsTable get eventRegistrations =>
      attachedDatabase.eventRegistrations;
  $BanksTable get banks => attachedDatabase.banks;
  $DetailedAccountsTable get detailedAccounts =>
      attachedDatabase.detailedAccounts;
  EventRegistrationsDaoManager get managers =>
      EventRegistrationsDaoManager(this);
}

class EventRegistrationsDaoManager {
  final _$EventRegistrationsDaoMixin _db;
  EventRegistrationsDaoManager(this._db);
  $$TeamsTableTableManager get teams =>
      $$TeamsTableTableManager(_db.attachedDatabase, _db.teams);
  $$UsersTableTableManager get users =>
      $$UsersTableTableManager(_db.attachedDatabase, _db.users);
  $$EventsTableTableManager get events =>
      $$EventsTableTableManager(_db.attachedDatabase, _db.events);
  $$EventRegistrationsTableTableManager get eventRegistrations =>
      $$EventRegistrationsTableTableManager(
        _db.attachedDatabase,
        _db.eventRegistrations,
      );
  $$BanksTableTableManager get banks =>
      $$BanksTableTableManager(_db.attachedDatabase, _db.banks);
  $$DetailedAccountsTableTableManager get detailedAccounts =>
      $$DetailedAccountsTableTableManager(
        _db.attachedDatabase,
        _db.detailedAccounts,
      );
}
