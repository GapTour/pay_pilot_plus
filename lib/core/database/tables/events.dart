part of '../../database/app_database.dart';

class Events extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get title => text()();
  IntColumn get teamID =>
      integer().references(Teams, #id, onDelete: KeyAction.cascade)();
  DateTimeColumn get date => dateTime().withDefault(currentDate)();
  BoolColumn get isClosed => boolean().withDefault(const Constant(false))();
  BoolColumn get isActive => boolean().withDefault(const Constant(true))();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDate)();
}
