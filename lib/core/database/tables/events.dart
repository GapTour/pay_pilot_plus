part of '../../database/app_database.dart';

class Events extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get title => text()();
  IntColumn get teamID =>
      integer().references(Teams, #id, onDelete: KeyAction.cascade)();
  IntColumn get userID =>
      integer().references(Users, #id, onDelete: KeyAction.cascade)();
  Int64Column get entranceFee => int64()();
  Int64Column get snacksFee => int64()();
  DateTimeColumn get date => dateTime().withDefault(currentDate)();
  BoolColumn get isClosed => boolean().withDefault(const Constant(false))();
  BoolColumn get isActive => boolean().withDefault(const Constant(true))();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDate)();
}
