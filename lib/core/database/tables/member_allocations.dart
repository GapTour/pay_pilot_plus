part of '../../database/app_database.dart';

class MemberAllocations extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get userID =>
      integer().references(Users, #id, onDelete: KeyAction.restrict)();
  IntColumn get eventID =>
      integer().references(Events, #id, onDelete: KeyAction.restrict)();
  RealColumn get sharePercentage => real()();
  DateTimeColumn get createAt => dateTime().withDefault(currentDate)();

  @override
  List<Set<Column>> get uniqueKeys => [
    {eventID, userID},
  ];
}
