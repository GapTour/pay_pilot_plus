import 'package:pay_pilot_plus/core/data/models/user_model.dart';
import 'package:pay_pilot_plus/core/database/app_database.dart'
    show RegistrationStatus;

class EventRegistrationModel {
  final int id;
  final UserModel user;
  final RegistrationStatus status;
  final BigInt grossAmount;
  final BigInt discountAmount;
  final BigInt netAmount;
  final DateTime registeredAt;

  new({
    required this.id,
    required this.user,
    required this.status,
    required this.grossAmount,
    required this.discountAmount,
    required this.netAmount,
    required this.registeredAt,
  });
}
