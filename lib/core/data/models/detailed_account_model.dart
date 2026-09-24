// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:pay_pilot_plus/core/database/app_database.dart'
    show DetailedAccountType;
import 'package:pay_pilot_plus/core/utils/helpers/data_models_helper.dart';

class DetailedAccountModel {
  final int id;
  final String code;
  final String name;
  final DetailedAccountType type;
  final ({int id, String name})? userInfo;
  final ({int id, String name})? eventInfo;
  final ({int id, String name})? bankInfo;
  final bool isActive;
  DetailedAccountModel({
    required this.id,
    required this.code,
    required this.name,
    required this.type,
    required this.userInfo,
    required this.eventInfo,
    required this.bankInfo,
    required this.isActive,
  });

  DetailedAccountModel copyWith({
    int? id,
    String? code,
    String? name,
    DetailedAccountType? type,
    ({int id, String name})? userInfo,
    ({int id, String name})? eventInfo,
    ({int id, String name})? bankInfo,
    bool? isActive,
  }) {
    return DetailedAccountModel(
      id: id ?? this.id,
      code: code ?? this.code,
      name: name ?? this.name,
      type: type ?? this.type,
      userInfo: userInfo ?? this.userInfo,
      eventInfo: eventInfo ?? this.eventInfo,
      bankInfo: bankInfo ?? this.bankInfo,
      isActive: isActive ?? this.isActive,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'code': code,
      'name': name,
      'type': type.title,
      'userInfo': userInfo == null
          ? null
          : <String, dynamic>{'id': userInfo!.id, 'name': userInfo!.name},
      'eventInfo': eventInfo == null
          ? null
          : <String, dynamic>{'id': eventInfo!.id, 'name': eventInfo!.name},
      'bankInfo': bankInfo == null
          ? null
          : <String, dynamic>{'id': bankInfo!.id, 'name': bankInfo!.name},
      'isActive': isActive,
    };
  }

  factory DetailedAccountModel.fromMap(Map<String, dynamic> map) {
    final userInfoData = map['userInfo'];
    final eventInfoData = map['eventInfo'];
    final bankInfoData = map['bankInfo'];

    return DetailedAccountModel(
      id: map['id'] as int,
      code: map['code'] as String,
      name: map['name'] as String,
      type: DetailedAccountType.fromTitle(map['type']),
      userInfo: DataModelsHelper.parseInfo(userInfoData),
      eventInfo: DataModelsHelper.parseInfo(eventInfoData),
      bankInfo: DataModelsHelper.parseInfo(bankInfoData),
      isActive: map['isActive'] as bool,
    );
  }

  String toJson() => json.encode(toMap());

  factory DetailedAccountModel.fromJson(String source) =>
      DetailedAccountModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
