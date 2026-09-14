part of '../../database/app_database.dart';

/// 1. گروه حساب‌ها (دارایی‌ها، بدهی‌ها، حقوق صاحبان سهام و...)
class AccountGroups extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get code => text().withLength(min: 1, max: 20).unique()();
  TextColumn get name => text().withLength(min: 1, max: 100)();
  TextColumn get type => textEnum<AccountGroupType>()();
  BoolColumn get isSystemDefault =>
      boolean().withDefault(const Constant(false))();
}
