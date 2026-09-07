import 'package:pay_pilot_plus/core/database/app_database.dart'
    show DetailedAccountType;

class DetailedAccountParams {
  final int? id;
  final int? attachmentID;
  final String name;
  final DetailedAccountType type;
  final bool isActive;

  DetailedAccountParams({
    required this.id,
    required this.attachmentID,
    required this.name,
    required this.type,
    this.isActive = true,
  });
}
