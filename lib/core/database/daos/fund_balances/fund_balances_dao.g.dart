// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'fund_balances_dao.dart';

// ignore_for_file: type=lint
mixin _$FundBalancesDaoMixin on DatabaseAccessor<AppDatabase> {
  $FundsTable get funds => attachedDatabase.funds;
  $FundBalancesTable get fundBalances => attachedDatabase.fundBalances;
  FundBalancesDaoManager get managers => FundBalancesDaoManager(this);
}

class FundBalancesDaoManager {
  final _$FundBalancesDaoMixin _db;
  FundBalancesDaoManager(this._db);
  $$FundsTableTableManager get funds =>
      $$FundsTableTableManager(_db.attachedDatabase, _db.funds);
  $$FundBalancesTableTableManager get fundBalances =>
      $$FundBalancesTableTableManager(_db.attachedDatabase, _db.fundBalances);
}
