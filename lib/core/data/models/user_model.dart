import 'dart:convert';

import 'package:pay_pilot_plus/core/database/app_database.dart'
    show UserAccountRole;
import 'package:pay_pilot_plus/core/utils/helpers/data_models_helper.dart';

class UserModel {
  final int id;
  final String name;
  final String? description;
  final String? phoneNumber;
  final bool isActive;
  final String? profileImage;
  final String? telegramID;
  final String? instagramID;
  final DateTime? birthday;
  final UserAccountRole role;
  final ({int id, String name, String code}) detailedAccountInfo;

  UserModel({
    required this.id,
    required this.name,
    required this.description,
    required this.phoneNumber,
    required this.isActive,
    required this.profileImage,
    required this.telegramID,
    required this.instagramID,
    required this.birthday,
    required this.role,
    required this.detailedAccountInfo,
  });

  UserModel copyWith({
    int? id,
    String? name,
    String? description,
    String? phoneNumber,
    bool? isActive,
    String? profileImage,
    String? telegramID,
    String? instagramID,
    DateTime? birthday,
    UserAccountRole? role,
    ({int id, String name, String code})? detailedAccountInfo,
  }) {
    return UserModel(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      isActive: isActive ?? this.isActive,
      profileImage: profileImage ?? this.profileImage,
      telegramID: telegramID ?? this.telegramID,
      instagramID: instagramID ?? this.instagramID,
      birthday: birthday ?? this.birthday,
      role: role ?? this.role,
      detailedAccountInfo: detailedAccountInfo ?? this.detailedAccountInfo,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'description': description,
      'phoneNumber': phoneNumber,
      'isActive': isActive,
      'profileImage': profileImage,
      'telegramID': telegramID,
      'instagramID': instagramID,
      'birthday': birthday?.millisecondsSinceEpoch,
      'role': role.toMap(),
      'detailedAccountInfo': <String, dynamic>{
        'id': detailedAccountInfo.id,
        'name': detailedAccountInfo.name,
        'code': detailedAccountInfo.code,
      },
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    final accountInfoData = map['detailedAccountInfo'];

    return UserModel(
      id: map['id'] as int,
      name: map['name'] as String,
      description: map['description'] != null
          ? map['description'] as String
          : null,
      phoneNumber: map['phoneNumber'] != null
          ? map['phoneNumber'] as String
          : null,
      isActive: map['isActive'] as bool,
      profileImage: map['profileImage'] != null
          ? map['profileImage'] as String
          : null,
      telegramID: map['telegramID'] != null
          ? map['telegramID'] as String
          : null,
      instagramID: map['instagramID'] != null
          ? map['instagramID'] as String
          : null,
      birthday: map['birthday'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['birthday'] as int)
          : null,
      role: UserAccountRole.fromMap(map['role'] as Map<String, dynamic>),
      detailedAccountInfo: DataModelsHelper.parseDetailedAccountInfo(
        accountInfoData,
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
