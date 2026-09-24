// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'fund_allocations_dao.dart';

// ignore_for_file: type=lint
mixin _$FundAllocationsDaoMixin on DatabaseAccessor<AppDatabase> {
  $FundsTable get funds => attachedDatabase.funds;
  $TeamsTable get teams => attachedDatabase.teams;
  $UsersTable get users => attachedDatabase.users;
  $EventsTable get events => attachedDatabase.events;
  $TeamFundsTable get teamFunds => attachedDatabase.teamFunds;
  $FundAllocationsTable get fundAllocations => attachedDatabase.fundAllocations;
  FundAllocationsDaoManager get managers => FundAllocationsDaoManager(this);
}

class FundAllocationsDaoManager {
  final _$FundAllocationsDaoMixin _db;
  FundAllocationsDaoManager(this._db);
  $$FundsTableTableManager get funds =>
      $$FundsTableTableManager(_db.attachedDatabase, _db.funds);
  $$TeamsTableTableManager get teams =>
      $$TeamsTableTableManager(_db.attachedDatabase, _db.teams);
  $$UsersTableTableManager get users =>
      $$UsersTableTableManager(_db.attachedDatabase, _db.users);
  $$EventsTableTableManager get events =>
      $$EventsTableTableManager(_db.attachedDatabase, _db.events);
  $$TeamFundsTableTableManager get teamFunds =>
      $$TeamFundsTableTableManager(_db.attachedDatabase, _db.teamFunds);
  $$FundAllocationsTableTableManager get fundAllocations =>
      $$FundAllocationsTableTableManager(
        _db.attachedDatabase,
        _db.fundAllocations,
      );
}
