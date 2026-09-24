// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'event_ads_dao.dart';

// ignore_for_file: type=lint
mixin _$EventAdsDaoMixin on DatabaseAccessor<AppDatabase> {
  $TeamsTable get teams => attachedDatabase.teams;
  $UsersTable get users => attachedDatabase.users;
  $EventsTable get events => attachedDatabase.events;
  $BanksTable get banks => attachedDatabase.banks;
  $EventAdsTable get eventAds => attachedDatabase.eventAds;
  EventAdsDaoManager get managers => EventAdsDaoManager(this);
}

class EventAdsDaoManager {
  final _$EventAdsDaoMixin _db;
  EventAdsDaoManager(this._db);
  $$TeamsTableTableManager get teams =>
      $$TeamsTableTableManager(_db.attachedDatabase, _db.teams);
  $$UsersTableTableManager get users =>
      $$UsersTableTableManager(_db.attachedDatabase, _db.users);
  $$EventsTableTableManager get events =>
      $$EventsTableTableManager(_db.attachedDatabase, _db.events);
  $$BanksTableTableManager get banks =>
      $$BanksTableTableManager(_db.attachedDatabase, _db.banks);
  $$EventAdsTableTableManager get eventAds =>
      $$EventAdsTableTableManager(_db.attachedDatabase, _db.eventAds);
}
