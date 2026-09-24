part of '../../database/app_database.dart';

class EventEntranceFees extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get eventID =>
      integer().references(Events, #id, onDelete: KeyAction.cascade)();
  IntColumn get hostID =>
      integer().references(Users, #id, onDelete: KeyAction.restrict)();
  IntColumn get bankID =>
      integer().references(Banks, #id, onDelete: KeyAction.restrict)();
  TextColumn get staffIDs => text().nullable()();
  Int64Column get entranceFee => int64()();
  Int64Column get snacksFee => int64()();
  Int64Column get totalExpenseAmount => int64()();
  IntColumn get totalGuests => integer()();
  TextColumn get description => text().nullable()();
  DateTimeColumn get paidAt => dateTime().withDefault(currentDateAndTime)();

  @override
  List<Set<Column>> get uniqueKeys => [
    {eventID, hostID},
  ];
}
