part of '../../database/app_database.dart';

class EventAds extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get eventID =>
      integer().references(Events, #id, onDelete: KeyAction.cascade)();
  IntColumn get staffID => integer().nullable().references(
    Users,
    #id,
    onDelete: KeyAction.restrict,
  )();
  IntColumn get bankID => integer().nullable().references(
    Banks,
    #id,
    onDelete: KeyAction.restrict,
  )();
  Int64Column get adsAmount => int64()();
  TextColumn get description => text().nullable()();
  DateTimeColumn get paidAt => dateTime().withDefault(currentDateAndTime)();
}
