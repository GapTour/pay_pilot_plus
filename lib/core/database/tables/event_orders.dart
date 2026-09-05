part of '../../database/app_database.dart';

class EventOrders extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get userID =>
      integer().references(Users, #id, onDelete: KeyAction.cascade)();
  IntColumn get eventID =>
      integer().references(Events, #id, onDelete: KeyAction.cascade)();
  BoolColumn get isDelivered => boolean().withDefault(const Constant(false))();
  TextColumn get menuItems => text().nullable()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDate)();
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDate)();
}
