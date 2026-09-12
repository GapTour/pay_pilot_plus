import 'package:pay_pilot_plus/core/database/app_database.dart'
    show RegistrationStatus;

class EventRegistrationParams {
  final int? id;
  final ({int id, String name}) eventInfo;
  final ({int id, String name})? bankInfo;
  final List<({int id, String name})> usersInfo;
  final RegistrationStatus status;
  final BigInt grossAmount;
  final BigInt discountAmount;
  final BigInt netAmount;
  final DateTime registeredAt;
  final String? description;
  // final int? lastCounterNumber;

  EventRegistrationParams({
    required this.id,
    required this.eventInfo,
    required this.bankInfo,
    required this.usersInfo,
    required this.status,
    required this.grossAmount,
    required this.discountAmount,
    required this.netAmount,
    required this.registeredAt,
    required this.description,
    // required this.lastCounterNumber,
  });
}
