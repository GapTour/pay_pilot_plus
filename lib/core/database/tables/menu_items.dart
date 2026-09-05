part of '../../database/app_database.dart';

class MenuItems extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get title => text()();
  BoolColumn get isActive => boolean().withDefault(const Constant(true))();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDate)();
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDate)();
}
