part of '../../database/app_database.dart';

/// 3. حساب‌های معین (بانک‌ها، صندوق، بدهکاران تجاری و...)
@DataClassName('SubsidiaryAccount')
class SubsidiaryAccounts extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get accountGroupId => integer().references(
    GeneralAccounts,
    #id,
    onUpdate: KeyAction.cascade,
    onDelete: KeyAction.restrict,
  )();
  IntColumn get generalAccountId => integer().references(
    GeneralAccounts,
    #id,
    onUpdate: KeyAction.cascade,
    onDelete: KeyAction.restrict,
  )();
  TextColumn get code => text().withLength(min: 4, max: 8).unique()();
  TextColumn get completeCode => text().withLength(min: 4, max: 8).unique()();
  TextColumn get name => text().withLength(min: 2, max: 100)();
  TextColumn get type => textEnum<SubsidiaryAccountType>()();
  BoolColumn get isSystemDefault =>
      boolean().withDefault(const Constant(false))();
}
