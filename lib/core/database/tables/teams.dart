part of '../../database/app_database.dart';

class Teams extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get title => text()();
  TextColumn get description => text().nullable()();
  BoolColumn get isActive => boolean().withDefault(const Constant(true))();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDate)();
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDate)();
}
