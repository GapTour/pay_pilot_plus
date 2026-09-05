// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'event_partner_shares_dao.dart';

// ignore_for_file: type=lint
mixin _$EventPartnerSharesDaoMixin on DatabaseAccessor<AppDatabase> {
  $UsersTable get users => attachedDatabase.users;
  $TeamsTable get teams => attachedDatabase.teams;
  $EventsTable get events => attachedDatabase.events;
  $TeamMembersTable get teamMembers => attachedDatabase.teamMembers;
  $EventPartnerSharesTable get eventPartnerShares =>
      attachedDatabase.eventPartnerShares;
  EventPartnerSharesDaoManager get managers =>
      EventPartnerSharesDaoManager(this);
}

class EventPartnerSharesDaoManager {
  final _$EventPartnerSharesDaoMixin _db;
  EventPartnerSharesDaoManager(this._db);
  $$UsersTableTableManager get users =>
      $$UsersTableTableManager(_db.attachedDatabase, _db.users);
  $$TeamsTableTableManager get teams =>
      $$TeamsTableTableManager(_db.attachedDatabase, _db.teams);
  $$EventsTableTableManager get events =>
      $$EventsTableTableManager(_db.attachedDatabase, _db.events);
  $$TeamMembersTableTableManager get teamMembers =>
      $$TeamMembersTableTableManager(_db.attachedDatabase, _db.teamMembers);
  $$EventPartnerSharesTableTableManager get eventPartnerShares =>
      $$EventPartnerSharesTableTableManager(
        _db.attachedDatabase,
        _db.eventPartnerShares,
      );
}
