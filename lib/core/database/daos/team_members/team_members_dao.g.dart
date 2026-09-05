// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'team_members_dao.dart';

// ignore_for_file: type=lint
mixin _$TeamMembersDaoMixin on DatabaseAccessor<AppDatabase> {
  $UsersTable get users => attachedDatabase.users;
  $TeamsTable get teams => attachedDatabase.teams;
  $TeamMembersTable get teamMembers => attachedDatabase.teamMembers;
  TeamMembersDaoManager get managers => TeamMembersDaoManager(this);
}

class TeamMembersDaoManager {
  final _$TeamMembersDaoMixin _db;
  TeamMembersDaoManager(this._db);
  $$UsersTableTableManager get users =>
      $$UsersTableTableManager(_db.attachedDatabase, _db.users);
  $$TeamsTableTableManager get teams =>
      $$TeamsTableTableManager(_db.attachedDatabase, _db.teams);
  $$TeamMembersTableTableManager get teamMembers =>
      $$TeamMembersTableTableManager(_db.attachedDatabase, _db.teamMembers);
}
