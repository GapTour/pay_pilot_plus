import 'package:pay_pilot_plus/core/database/app_database.dart'
    show RegistrationStatus;

class DeleteRegistrationParams {
  final int id;
  final int userID;
  final int eventID;
  final RegistrationStatus status;

  DeleteRegistrationParams({
    required this.id,
    required this.userID,
    required this.eventID,
    required this.status,
  });
}
