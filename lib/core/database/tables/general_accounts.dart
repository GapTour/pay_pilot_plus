part of '../../database/app_database.dart';

/// 2. حساب‌های کل (دارایی‌های جاری، موجودی نقد و...)
class GeneralAccounts extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get code => text().withLength(min: 1, max: 20).unique()();
  TextColumn get name => text().withLength(min: 1, max: 100)();
  IntColumn get groupID => integer().references(
    AccountGroups,
    #id,
    onUpdate: KeyAction.cascade,
    onDelete: KeyAction.restrict,
  )();
  TextColumn get type => textEnum<GeneralAccountType>()();
}
