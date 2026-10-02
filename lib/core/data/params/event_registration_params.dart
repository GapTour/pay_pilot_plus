import 'package:pay_pilot_plus/core/database/app_database.dart'
    show RegistrationStatus;

class EventRegistrationParams {
  final int? id;
  final ({int id, String name}) eventInfo;
  final ({int id, String name})? bankInfo;
  final ({int id, String name})? assignmentInfo;
  final List<({int id, String name})> guestsInfo;
  final RegistrationStatus status;
  final BigInt grossAmount;
  final BigInt discountAmount;
  final BigInt netAmount;
  final DateTime registeredAt;
  final String? description;

  EventRegistrationParams({
    required this.id,
    required this.eventInfo,
    required this.bankInfo,
    required this.assignmentInfo,
    required this.guestsInfo,
    required this.status,
    required this.grossAmount,
    required this.discountAmount,
    required this.netAmount,
    required this.registeredAt,
    required this.description,
  });
}
