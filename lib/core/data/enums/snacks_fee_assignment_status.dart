part of '../../database/app_database.dart';

enum SnacksFeeAssignmentStatus {
  unassign('سود این رویداد'),
  assignmentToStaff('از حساب پرسنلی'),
  assignmentToFund('از کیف ذخیره');

  final String title;
  const SnacksFeeAssignmentStatus(this.title);

  /// عنوان قابل ترجمه برای نمایش در رابط کاربری؛ `title` ثابت می‌ماند
  /// چون برای سریال‌سازی و نام حساب‌های ذخیره‌شده استفاده می‌شود.
  String get localizedTitle => switch (this) {
    unassign => S.current.snacksAssignment_unassign,
    assignmentToStaff => S.current.snacksAssignment_assignmentToStaff,
    assignmentToFund => S.current.snacksAssignment_assignmentToFund,
  };

  bool get isUnassign => this == .unassign;
  bool get isAssignmentToFund => this == .assignmentToFund;
  bool get isAssignmentToStaff => this == .assignmentToStaff;
}
