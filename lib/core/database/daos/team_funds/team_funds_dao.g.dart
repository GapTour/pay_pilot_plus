// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'team_funds_dao.dart';

// ignore_for_file: type=lint
mixin _$TeamFundsDaoMixin on DatabaseAccessor<AppDatabase> {
  $FundsTable get funds => attachedDatabase.funds;
  $TeamsTable get teams => attachedDatabase.teams;
  $TeamFundsTable get teamFunds => attachedDatabase.teamFunds;
  TeamFundsDaoManager get managers => TeamFundsDaoManager(this);
}

class TeamFundsDaoManager {
  final _$TeamFundsDaoMixin _db;
  TeamFundsDaoManager(this._db);
  $$FundsTableTableManager get funds =>
      $$FundsTableTableManager(_db.attachedDatabase, _db.funds);
  $$TeamsTableTableManager get teams =>
      $$TeamsTableTableManager(_db.attachedDatabase, _db.teams);
  $$TeamFundsTableTableManager get teamFunds =>
      $$TeamFundsTableTableManager(_db.attachedDatabase, _db.teamFunds);
}
