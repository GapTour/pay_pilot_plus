part of '../../database/app_database.dart';

/// 6. آرتیکل‌ها / ردیف‌های سند حسابداری (بدهکار/بستانکار)
@DataClassName('JournalLine')
class JournalLines extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get headerId => integer().references(
    JournalHeaders,
    #id,
    onUpdate: KeyAction.cascade,
    onDelete: KeyAction.cascade,
  )();

  IntColumn get subsidiaryId => integer().references(
    SubsidiaryAccounts,
    #id,
    onUpdate: KeyAction.cascade,
    onDelete: KeyAction.restrict,
  )();

  // تفصیلی می‌تواند نال باشد (برای معین‌هایی که تفصیلی‌پذیر نیستند)
  @ReferenceName('firstDetailedId')
  IntColumn get firstDetailedId => integer().nullable().references(
    DetailedAccounts,
    #id,
    onUpdate: KeyAction.cascade,
    onDelete: KeyAction.restrict,
  )();
  @ReferenceName('secondDetailedId')
  IntColumn get secondDetailedId => integer().nullable().references(
    DetailedAccounts,
    #id,
    onUpdate: KeyAction.cascade,
    onDelete: KeyAction.restrict,
  )();

  // استفاده از Int64 (BigInt) برای جلوگیری از خطای اعشار در محاسبات مالی
  Int64Column get debit => int64()();
  Int64Column get credit => int64()();

  TextColumn get series => text()();
  TextColumn get memo => text().nullable()();
  TextColumn get noticeMemo => text().nullable()();
  DateTimeColumn get date => dateTime().withDefault(currentDate)();
  BoolColumn get hasSource => boolean().withDefault(Constant(true))();

  // جلوگیری از مقادیر منفی در دیتابیس
  @override
  List<String> get customConstraints => [
    'CHECK (debit >= 0)',
    'CHECK (credit >= 0)',
    'CHECK (debit = 0 OR credit = 0)', // یک ردیف نمی‌تواند همزمان هم بدهکار و هم بستانکار باشد
  ];
}
