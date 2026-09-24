part of '../../database/app_database.dart';

class FundAllocations extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get fundID =>
      integer().references(Funds, #id, onDelete: KeyAction.restrict)();
  IntColumn get eventID =>
      integer().references(Events, #id, onDelete: KeyAction.restrict)();
  RealColumn get sharePercentage => real()();
  DateTimeColumn get createAt => dateTime().withDefault(currentDate)();

  @override
  List<Set<Column>> get uniqueKeys => [
    {eventID, fundID},
  ];
}
