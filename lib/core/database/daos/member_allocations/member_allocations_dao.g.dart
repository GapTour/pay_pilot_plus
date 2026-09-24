// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'member_allocations_dao.dart';

// ignore_for_file: type=lint
mixin _$MemberAllocationsDaoMixin on DatabaseAccessor<AppDatabase> {
  $UsersTable get users => attachedDatabase.users;
  $TeamsTable get teams => attachedDatabase.teams;
  $EventsTable get events => attachedDatabase.events;
  $TeamMembersTable get teamMembers => attachedDatabase.teamMembers;
  $MemberAllocationsTable get memberAllocations =>
      attachedDatabase.memberAllocations;
  MemberAllocationsDaoManager get managers => MemberAllocationsDaoManager(this);
}

class MemberAllocationsDaoManager {
  final _$MemberAllocationsDaoMixin _db;
  MemberAllocationsDaoManager(this._db);
  $$UsersTableTableManager get users =>
      $$UsersTableTableManager(_db.attachedDatabase, _db.users);
  $$TeamsTableTableManager get teams =>
      $$TeamsTableTableManager(_db.attachedDatabase, _db.teams);
  $$EventsTableTableManager get events =>
      $$EventsTableTableManager(_db.attachedDatabase, _db.events);
  $$TeamMembersTableTableManager get teamMembers =>
      $$TeamMembersTableTableManager(_db.attachedDatabase, _db.teamMembers);
  $$MemberAllocationsTableTableManager get memberAllocations =>
      $$MemberAllocationsTableTableManager(
        _db.attachedDatabase,
        _db.memberAllocations,
      );
}
