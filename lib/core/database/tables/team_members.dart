part of '../../database/app_database.dart';

class TeamMembers extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get userID =>
      integer().references(Users, #id, onDelete: KeyAction.cascade)();
  IntColumn get teamID =>
      integer().references(Teams, #id, onDelete: KeyAction.cascade)();
  RealColumn get sharePercentage => real()();
  DateTimeColumn get createAt => dateTime().withDefault(currentDate)();
}
