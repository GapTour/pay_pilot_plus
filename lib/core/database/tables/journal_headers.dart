part of '../../database/app_database.dart';

enum JournalType {
  normal('عادی'), // سند عادی روزمره
  opening('افتتاحیه'), // سند افتتاحیه اول دوره
  closing('اختتامیه'); // سند اختتامیه پایان دوره

  final String title;
  const JournalType(this.title);

  /// عنوان قابل ترجمه برای نمایش در رابط کاربری؛ `title` ثابت می‌ماند
  /// چون برای سریال‌سازی و نام حساب‌های ذخیره‌شده استفاده می‌شود.
  String get localizedTitle => switch (this) {
    normal => S.current.journalType_normal,
    opening => S.current.journalType_opening,
    closing => S.current.journalType_closing,
  };

  factory JournalType.fromTitle(String title) {
    return JournalType.values.firstWhere(
      (type) => type.title == title,
      orElse: () => throw ArgumentError('Invalid title: $title'),
    );
  }
}

/// 5. هدر سند حسابداری (شماره سند، تاریخ، شرح کل)
@DataClassName('JournalHeader')
class JournalHeaders extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get entryNumber => text().unique()();
  DateTimeColumn get entryDate => dateTime()();
  TextColumn get description => text().nullable()();
  TextColumn get type =>
      textEnum<JournalType>().withDefault(Constant(JournalType.normal.name))();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDate)();
}
