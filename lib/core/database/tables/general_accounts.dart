part of '../../database/app_database.dart';

/// 2. حساب‌های کل (دارایی‌های جاری، موجودی نقد و...)
class GeneralAccounts extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get code => text().withLength(min: 1, max: 20).unique()();
  TextColumn get completeCode => text().withLength(min: 4, max: 8).unique()();
  TextColumn get name => text().withLength(min: 1, max: 100)();
  IntColumn get accountGroupId => integer().references(
    AccountGroups,
    #id,
    onUpdate: KeyAction.cascade,
    onDelete: KeyAction.restrict,
  )();
  TextColumn get type => textEnum<GeneralAccountType>()();
  BoolColumn get isSystemDefault =>
      boolean().withDefault(const Constant(false))();
}
