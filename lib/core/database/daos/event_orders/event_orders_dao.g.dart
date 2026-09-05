// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'event_orders_dao.dart';

// ignore_for_file: type=lint
mixin _$EventOrdersDaoMixin on DatabaseAccessor<AppDatabase> {
  $UsersTable get users => attachedDatabase.users;
  $TeamsTable get teams => attachedDatabase.teams;
  $EventsTable get events => attachedDatabase.events;
  $EventOrdersTable get eventOrders => attachedDatabase.eventOrders;
  EventOrdersDaoManager get managers => EventOrdersDaoManager(this);
}

class EventOrdersDaoManager {
  final _$EventOrdersDaoMixin _db;
  EventOrdersDaoManager(this._db);
  $$UsersTableTableManager get users =>
      $$UsersTableTableManager(_db.attachedDatabase, _db.users);
  $$TeamsTableTableManager get teams =>
      $$TeamsTableTableManager(_db.attachedDatabase, _db.teams);
  $$EventsTableTableManager get events =>
      $$EventsTableTableManager(_db.attachedDatabase, _db.events);
  $$EventOrdersTableTableManager get eventOrders =>
      $$EventOrdersTableTableManager(_db.attachedDatabase, _db.eventOrders);
}
