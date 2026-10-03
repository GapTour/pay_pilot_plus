import 'package:pay_pilot_plus/core/database/app_database.dart'
    show SnacksFeeAssignmentStatus;

class SnacksFeeAssignmentParams {
  final ({int id, String name, int accountID}) snacksAssignmentInfo;
  final ({int id, String name, int accountID}) guestInfo;
  final SnacksFeeAssignmentStatus snacksAssignmentStatus;

  SnacksFeeAssignmentParams({
    required this.snacksAssignmentInfo,
    required this.guestInfo,
    required this.snacksAssignmentStatus,
  });
}
