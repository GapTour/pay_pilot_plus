part of '../../database/app_database.dart';

enum SnacksFeeAssignmentStatus {
  unassign('سود این رویداد'),
  assignmentToStaff('از حساب پرسنلی'),
  assignmentToFund('از کیف ذخیره');

  final String title;
  const SnacksFeeAssignmentStatus(this.title);

  bool get isUnassign => this == .unassign;
  bool get isAssignmentToFund => this == .assignmentToFund;
  bool get isAssignmentToStaff => this == .assignmentToStaff;
}
