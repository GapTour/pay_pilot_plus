// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'funds_dao.dart';

// ignore_for_file: type=lint
mixin _$FundsDaoMixin on DatabaseAccessor<AppDatabase> {
  $FundsTable get funds => attachedDatabase.funds;
  FundsDaoManager get managers => FundsDaoManager(this);
}

class FundsDaoManager {
  final _$FundsDaoMixin _db;
  FundsDaoManager(this._db);
  $$FundsTableTableManager get funds =>
      $$FundsTableTableManager(_db.attachedDatabase, _db.funds);
}
