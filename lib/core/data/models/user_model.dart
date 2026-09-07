import 'package:pay_pilot_plus/core/database/app_database.dart'
    show UserAccountRole;

class UserModel {
  final int userID;
  final int detailedAccountID;
  final String accountCode;
  final String accountName;
  final String name;
  final String? description;
  final String? phoneNumber;
  final bool isActive;
  final String? profileImage;
  final String? telegramID;
  final String? instagramID;
  final DateTime? birthday;
  final UserAccountRole role;

  UserModel({
    required this.userID,
    required this.detailedAccountID,
    required this.accountCode,
    required this.accountName,
    required this.name,
    required this.description,
    required this.phoneNumber,
    required this.isActive,
    required this.profileImage,
    required this.telegramID,
    required this.instagramID,
    required this.birthday,
    required this.role,
  });
}
