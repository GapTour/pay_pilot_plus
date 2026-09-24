// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'event_entrance_fees_dao.dart';

// ignore_for_file: type=lint
mixin _$EventEntranceFeesDaoMixin on DatabaseAccessor<AppDatabase> {
  $TeamsTable get teams => attachedDatabase.teams;
  $UsersTable get users => attachedDatabase.users;
  $EventsTable get events => attachedDatabase.events;
  $BanksTable get banks => attachedDatabase.banks;
  $EventEntranceFeesTable get eventEntranceFees =>
      attachedDatabase.eventEntranceFees;
  EventEntranceFeesDaoManager get managers => EventEntranceFeesDaoManager(this);
}

class EventEntranceFeesDaoManager {
  final _$EventEntranceFeesDaoMixin _db;
  EventEntranceFeesDaoManager(this._db);
  $$TeamsTableTableManager get teams =>
      $$TeamsTableTableManager(_db.attachedDatabase, _db.teams);
  $$UsersTableTableManager get users =>
      $$UsersTableTableManager(_db.attachedDatabase, _db.users);
  $$EventsTableTableManager get events =>
      $$EventsTableTableManager(_db.attachedDatabase, _db.events);
  $$BanksTableTableManager get banks =>
      $$BanksTableTableManager(_db.attachedDatabase, _db.banks);
  $$EventEntranceFeesTableTableManager get eventEntranceFees =>
      $$EventEntranceFeesTableTableManager(
        _db.attachedDatabase,
        _db.eventEntranceFees,
      );
}
