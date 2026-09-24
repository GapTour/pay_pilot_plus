// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'fund_balances_dao.dart';

// ignore_for_file: type=lint
mixin _$FundBalancesDaoMixin on DatabaseAccessor<AppDatabase> {
  $FundsTable get funds => attachedDatabase.funds;
  $TeamsTable get teams => attachedDatabase.teams;
  $UsersTable get users => attachedDatabase.users;
  $EventsTable get events => attachedDatabase.events;
  $FundBalancesTable get fundBalances => attachedDatabase.fundBalances;
  FundBalancesDaoManager get managers => FundBalancesDaoManager(this);
}

class FundBalancesDaoManager {
  final _$FundBalancesDaoMixin _db;
  FundBalancesDaoManager(this._db);
  $$FundsTableTableManager get funds =>
      $$FundsTableTableManager(_db.attachedDatabase, _db.funds);
  $$TeamsTableTableManager get teams =>
      $$TeamsTableTableManager(_db.attachedDatabase, _db.teams);
  $$UsersTableTableManager get users =>
      $$UsersTableTableManager(_db.attachedDatabase, _db.users);
  $$EventsTableTableManager get events =>
      $$EventsTableTableManager(_db.attachedDatabase, _db.events);
  $$FundBalancesTableTableManager get fundBalances =>
      $$FundBalancesTableTableManager(_db.attachedDatabase, _db.fundBalances);
}
