part of '../../database/app_database.dart';

enum RegistrationStatus {
  pending,
  confirmed,
  cancelled;

  bool get isPending => this == RegistrationStatus.pending;
  bool get isConfirmed => this == RegistrationStatus.confirmed;
  bool get isCancelled => this == RegistrationStatus.cancelled;

  Map<String, dynamic> toMap() => {'status': name};

  factory RegistrationStatus.fromMap(Map<String, dynamic> map) {
    final status = map['status'];

    if (status is! String) {
      throw ArgumentError('Missing or invalid registration status');
    }

    return RegistrationStatus.values.firstWhere(
      (value) => value.name == status,
      orElse: () => throw ArgumentError('Invalid registration status: $status'),
    );
  }
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
  BoolColumn get wasAbsent => boolean().withDefault(const Constant(true))();
  TextColumn get description => text().nullable()();
  DateTimeColumn get registeredAt =>
      dateTime().withDefault(currentDateAndTime)();

  @override
  List<Set<Column>> get uniqueKeys => [
    {eventID, userID},
  ];
}
