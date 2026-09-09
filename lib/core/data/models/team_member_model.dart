import 'dart:convert';

import 'package:pay_pilot_plus/core/utils/helpers/data_models_helper.dart';

class TeamMemberModel {
  final int id;
  final ({int id, String name}) teamInfo;
  final ({int id, String name}) userInfo;
  final double sharePercentage;

  TeamMemberModel({
    required this.id,
    required this.sharePercentage,
    required this.teamInfo,
    required this.userInfo,
  });

  TeamMemberModel copyWith({
    int? id,
    double? sharePercentage,
    ({int id, String name})? teamInfo,
    ({int id, String name})? userInfo,
  }) {
    return TeamMemberModel(
      id: id ?? this.id,
      sharePercentage: sharePercentage ?? this.sharePercentage,
      teamInfo: teamInfo ?? this.teamInfo,
      userInfo: userInfo ?? this.userInfo,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'sharePercentage': sharePercentage,
      'teamInfo': <String, dynamic>{'id': teamInfo.id, 'name': teamInfo.name},
      'userInfo': <String, dynamic>{'id': userInfo.id, 'name': userInfo.name},
    };
  }

  factory TeamMemberModel.fromMap(Map<String, dynamic> map) {
    final teamInfoData = map['teamInfo'];
    final userInfoData = map['userInfo'];

    return TeamMemberModel(
      id: map['id'] as int,
      sharePercentage: map['sharePercentage'] as double,
      teamInfo: DataModelsHelper.parseInfo(teamInfoData),
      userInfo: DataModelsHelper.parseInfo(userInfoData),
    );
  }

  String toJson() => json.encode(toMap());

  factory TeamMemberModel.fromJson(String source) =>
      TeamMemberModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
