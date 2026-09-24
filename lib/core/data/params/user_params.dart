import 'package:pay_pilot_plus/core/database/app_database.dart'
    show UserAccountRole;

class UserParams {
  final int? id;
  final String name;
  final String? description;
  final String? profileImage;
  final bool isActive;
  final String? telegramID;
  final String? instagramID;
  final String? phone;
  final DateTime? birthday;
  final BigInt? openingBalance;
  final UserAccountRole role;

  UserParams({
    required this.id,
    required this.name,
    required this.description,
    required this.profileImage,
    required this.isActive,
    required this.telegramID,
    required this.instagramID,
    required this.phone,
    required this.birthday,
    required this.openingBalance,
    required this.role,
  });
}
