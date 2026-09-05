part of '../../database/app_database.dart';

enum RegistrationStatus {
  pending,
  confirmed,
  cancelled;

  bool get isPending => this == RegistrationStatus.pending;
  bool get isConfirmed => this == RegistrationStatus.confirmed;
  bool get isCancelled => this == RegistrationStatus.cancelled;
}

class EventRegistrations extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get eventID =>
      integer().references(Events, #id, onDelete: KeyAction.cascade)();
  IntColumn get userID =>
      integer().references(Users, #id, onDelete: KeyAction.restrict)();
  TextColumn get status => textEnum<RegistrationStatus>().withDefault(
    Constant(RegistrationStatus.pending.name),
  )();
  Int64Column get grossAmount => int64()();
  Int64Column get discountAmount => int64()();
  Int64Column get netAmount => int64()();
  DateTimeColumn get registeredAt =>
      dateTime().withDefault(currentDateAndTime)();

  @override
  List<Set<Column>> get uniqueKeys => [
    {eventID, userID},
  ];
}
