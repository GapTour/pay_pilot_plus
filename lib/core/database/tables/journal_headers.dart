part of '../../database/app_database.dart';

enum JournalType {
  normal, // سند عادی روزمره
  opening, // سند افتتاحیه اول دوره
  closing, // سند اختتامیه پایان دوره
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
