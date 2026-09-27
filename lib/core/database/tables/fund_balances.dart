part of '../../database/app_database.dart';

class FundBalances extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get fundID =>
      integer().references(Funds, #id, onDelete: KeyAction.cascade)();
  TextColumn get series => text()();
  Int64Column get debit => int64()();
  Int64Column get credit => int64()();
  DateTimeColumn get date => dateTime().withDefault(currentDate)();
  TextColumn get memo => text().nullable()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDate)();
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDate)();
}
